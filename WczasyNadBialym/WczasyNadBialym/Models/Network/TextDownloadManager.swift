//
//  TextDownloadManager.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 24.10.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    func downloadTextAsync (_ textPath: String, _ completionHandlerForAsyncTextDownload: @escaping (_ resultData: NSString, _ error: NSError?) -> Void) {
        
        let controller = textPath
        let method  = ""
        let parameters = [String: String]()
        let datatype = DownloadedDataType.data
        
        let _ = taskForDownloadContent(controller, method, parameters, datatype) { (data, error) in
            
            if let error = error {
                LogEventHandler.report(LogEventType.debug, "Unable to download text", error.localizedDescription)
            } else {
                if let unwrappedData = data {
                    
                    if let result = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue) {
                        completionHandlerForAsyncTextDownload(result, nil)
                    }
                }
            }
        }
    }
}
