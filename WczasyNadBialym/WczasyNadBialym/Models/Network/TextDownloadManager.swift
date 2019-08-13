//
//  TextDownloadManager.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 24.10.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    @objc func downloadTextAsync (_ textPath: String, _ completionHandlerForAsyncTextDownload: @escaping (_ resultData: NSString, _ error: NSError?) -> Void) {
        
        let controller = textPath
        let method  = ""
        let parameters = [String: String]()
        let datatype = DownloadedDataType.data
        
        let request = NSMutableURLRequest(url: buildURLFromParameters(controller, method, parameters, datatype)) as URLRequest
        
        downloadContent(with: request) { (result) in
            switch result {
            case .success(let data):
                if let result = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    completionHandlerForAsyncTextDownload(result, nil)
                }
                
            case .failure(let error):
                LogEventHandler.report(LogEventType.debug, "Unable to download text", error.localizedDescription)
            }
        }
    }
}
