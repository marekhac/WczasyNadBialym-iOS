//
//  NetworkController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 20/05/2020.
//  Copyright © 2020 Marek Hać. All rights reserved.
//
//  Network Unit Testing patterns inspired by S.T.Huang article:
//  https://medium.com/flawless-app-stories/the-complete-guide-to-network-unit-testing-in-swift-db8b3ee2c327

import Foundation

final class NetworkController: NetworkProtocol {
    
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
        
        urlString = API.Scheme + API.Host + API.Path + controller + method
        
        if (datatype == .json) {
            
            var parametersWithAppId = parameters;
            parametersWithAppId["appid"] = API.AppId;
            
            for (key, value) in parametersWithAppId {
                urlString.append("/\(key)/\(value)")
            }
        }
        
        LogEventHandler.report(LogEventType.debug, "DOWNLOAD FILE FROM: \(urlString)")
        
        return NSURL(string: urlString)! as URL
    }
}
