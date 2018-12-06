//
//  NetworkManager.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 08.02.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation
class NetworkManager : NSObject {
   
    // shared session
    var session = URLSession.shared

    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    func taskForDownloadContent(_ controller: String, _ method: String, _ parameters: [String:String], _ datatype: DownloadedDataType = .json, completionHandlerForDownloadData: @escaping (_ result: Data?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        let request = NSMutableURLRequest(url: buildURLFromParameters(controller, method, parameters, datatype, withPathExtension: method))
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                let errorData : Data? = nil
                completionHandlerForDownloadData(errorData, NSError(domain: "taskForDownloadContent", code: 1, userInfo: userInfo))
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
            
            completionHandlerForDownloadData(data, nil)
        }
        
        task.resume()
        
        return task
    }
    
    // create a URL from parameters
    
    private func buildURLFromParameters(_ controller: String, _ method: String, _ parameters: [String:String], _ datatype : DownloadedDataType, withPathExtension: String? = nil) -> URL
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
        
        print("DOWNLOAD FILE FROM: \(urlString)")
        
        return NSURL(string: urlString)! as URL
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> NetworkManager {
        struct Singleton {
            static var sharedInstance = NetworkManager()
        }
        return Singleton.sharedInstance
    }
}
