//
//  NetworkManager.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 08.02.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//
//  Network Unit Testing patterns inspired by S.T.Huang article:
//  https://medium.com/flawless-app-stories/the-complete-guide-to-network-unit-testing-in-swift-db8b3ee2c327

import Foundation

class NetworkManager : NSObject {

    typealias completeClousure = (Result<Data, Error>) -> Void

    // session should be either URLSession or MockURLSession
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        
        // "session" is injected, and can be a mocked for test purposes
        
        self.session = session
    }
    
    func downloadContent(with request: URLRequest, completionHandlerForDownloadData: @escaping completeClousure) {
    
        let task = session.dataTask(with: request) { (data, response, error) in
            
            func sendError(_ errorString: String) {
                LogEventHandler.report(LogEventType.error, errorString)
                let userInfo = [NSLocalizedDescriptionKey : errorString]
                let error = NSError(domain: "downloadContent", code: 1, userInfo: userInfo)
                
                completionHandlerForDownloadData(.failure(error))
            }
            
            guard (error == nil) else {
                sendError("There was an error with your request: \(String(describing: error))")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            completionHandlerForDownloadData(.success(data))
        }
        
        task.resume()
    }
    
    // create a URL from parameters
    
    func buildURLFromParameters(_ controller: String, _ method: String, _ parameters: [String:String], _ datatype : DownloadedDataType = .json) -> URL
    {
        var urlString : String = ""
        
        // create final url
        
        urlString = NetworkManager.Constants.ApiScheme +
              NetworkManager.Constants.ApiHost +
              NetworkManager.Constants.ApiPath +
              controller + method

        if (datatype == .json) {
            
            var parametersWithAppId = parameters;
            parametersWithAppId["appid"] = NetworkManager.Constants.AppId;
            
            for (key, value) in parametersWithAppId {
                urlString.append("/\(key)/\(value)")
            }
        }
        
        LogEventHandler.report(LogEventType.debug, "DOWNLOAD FILE FROM: \(urlString)")
        
        
        return NSURL(string: urlString)! as URL
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> NetworkManager {
        struct Singleton {
            static var sharedInstance = NetworkManager(session: URLSession.shared)
        }
        return Singleton.sharedInstance
    }
}

extension URLSession: URLSessionProtocol {
    
    // add dataTask method that return URLSessionDataTaskProtocol
    // no changes in dataTask behavior, just convertion of returning type
    
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {
    // has the exact protocol method, resume(), so nothing happens
}
