//
//  ImageDownloadManager.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 27.03.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    func downloadImagesAsync (_ imagePath:String, _ completionHandlerForAsyncImageDownload: @escaping (_ resultData: Data?, _ error: NSError?) -> Void) {
        
        let controller = imagePath
        let method  = ""
        let parameters = [String: String]()
        let datatype = DownloadedDataType.data
        
        let _ = taskForDownloadContent(controller, method, parameters, datatype) { (data, error) in

            if let error = error {
                ErrorHandler.report("Unable to download na image", error.localizedDescription)
                completionHandlerForAsyncImageDownload(nil, error)
            } else {
                completionHandlerForAsyncImageDownload(data, nil)
            }
        }
    }
}
