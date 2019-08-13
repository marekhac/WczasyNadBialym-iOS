//
//  NetworkManagerTests.swift
//  WczasyNadBialymTests
//
//  Created by Marek Hać on 09/08/2019.
//  Copyright © 2019 Marek Hać. All rights reserved.
//

import XCTest
@testable import WczasyNadBialym
class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager!
    
    // mock the session object
    
    let session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        
        // inject the mock object to session inside Network Manager
        // instead URLSession.shared
        
        networkManager = NetworkManager(session: session)

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
   
    func test_Request_Verification() {
        
        guard let url = URL(string: "https://wczasynadbialym.pl") else {
            fatalError("URL can't be empty")
        }

        let request = NSMutableURLRequest(url: url) as URLRequest
        
        networkManager.downloadContent(with: request) { (result) in
            // Return data
        }
        
        XCTAssert(session.lastURL == url)
    }
    
    func test_Weather_GetAndVerifyJSON() {
        
        let jsonData = "{\"temp\":26.18,\"humidity\":61,\"pressure\":1014}".data(using: .utf8)
        
        session.nextData = jsonData
        networkManager.getCurrentMeasurement() { (weather) in
        
            guard weather != nil else {
                XCTFail("cannot parse weather JSON")
                return
            }
        }
    }
}

class MockURLSession: URLSessionProtocol {
    
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    
    private (set) var lastURL: URL?
    var url: URL?
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    // implementation of mocked dataTask method
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        
        // returns the final url we have submitted in the "get" method
        
        lastURL = request.url
        
        completionHandler(nextData, successHttpURLResponse(request: request), nextError)
        return nextDataTask // object of type MockURLSessionDataTask can be treated as URLSessionDataTask
    }
    
      func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.url = url
        return URLSession.shared.dataTask(with: url)
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    
    func resume() {
       // no changes in implementation
    }
}

extension NetworkManagerTests {
    
    typealias DataCompletion = (NSData?, URLResponse?, NSError?) -> Void
    
    class URLSessionDataTaskMock: URLSessionDataTask {
        private let closure: () -> Void

        init(closure: @escaping () -> Void) {
            self.closure = closure
        }
        
        // We override the 'resume' method and simply call our closure
        // instead of actually resuming any task.
        
        override func resume() {
            closure()
        }
    }
        
    class URLSessionMock: URLSession {
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        
        // Properties that enable us to set exactly what data or error
        // we want our mocked URLSession to return for any request.
        var data: Data?
        var error: Error?
        
        override func dataTask(
            with url: URL,
            completionHandler: @escaping CompletionHandler
            ) -> URLSessionDataTask {
            let data = self.data
            let error = self.error
            
            return URLSessionDataTaskMock {
                completionHandler(data, nil, error)
            }
        }
    }
}
