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
        
        let jsonData = #"""
            {
                "temp": 22.71,
                "humidity": 68,
                "pressure": 1030
            }
            """#.data(using: .utf8)
        
        session.nextData = jsonData
        networkManager.getCurrentMeasurement() { (weather) in
        
            guard weather != nil else {
                XCTFail("cannot parse weather JSON")
                return
            }
        }
    }
    
    func test_EventList_GetAndVerifyJSON() {
        let jsonData = #"""
            [
                {
                    "id": 78,
                    "name": "Sacrum w Architekturze Wlodawy i okolic",
                    "date": "30.08.2019 12:00",
                    "place": "Wlodawa"
                },
                {
                    "id": 71,
                    "name": "XRS Poland Wlodawa Procircuit race vol. 2",
                    "date": "31.08.2019 13:00",
                    "place": "Wlodawa, ul. Chelmska 94"
                }
            ]
            """#.data(using: .utf8)
        
        session.nextData = jsonData
        networkManager.getEventsList() { (eventsDict) in
            
            if let eventsDict = eventsDict {
                if (eventsDict.isEmpty) {
                    XCTFail("cannot parse event list JSON")
                    return
                }
            }
        }
    }
    
    func test_EventDetails_GetAndVerifyJSON() {
        let jsonData = #"""
            {
                "id": "78",
                "name": "Sacrum w Architekturze Włodawy i okolic",
                "place": "Włodawa",
                "date": "30.08.2019 12:00",
                "imgMedURL": "../img/kalendarz_imprez/2019/78/main/78_main_med.jpg",
                "imgFullURL": "../img/kalendarz_imprez/2019/78/main/78_main.jpg",
                "description": "Serdecznie zapraszamy zainteresowanych na plenerowe chwile z artystami."
            }
            """#.data(using: .utf8)

        session.nextData = jsonData
        networkManager.getEventDetails("1") { (eventDetails) in
            
            guard eventDetails != nil else {
                XCTFail("cannot parse event details JSON")
                return
            }
        }
    }
    
    func test_downloadImageAsync_GetAndVerify() {
        
        let sampleImage = #imageLiteral(resourceName: "wczasy_logo")
        let sampleImageData = sampleImage.pngData()
        
        session.nextData = sampleImageData
        networkManager.downloadImagesAsync("testurl") { (result) in

            switch result {
            
            case .success(let imageData):
                 XCTAssertEqual(imageData, sampleImageData, "downloaded image data and sample image data should be the same")               
            case .failure(_):
                XCTFail("cannot download")
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
