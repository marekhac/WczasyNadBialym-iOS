//
//  ImageDownloadManager.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 27.03.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    func downloadImagesAsync (_ imagePath:String, _ completionHandlerForAsyncImageDownload: @escaping (Result<Data,Error>) -> Void) {
        
        let controller = imagePath
        let method  = ""
        let parameters = [String: String]()
        let datatype = DownloadedDataType.data
        
        let _ = taskForDownloadContent(controller, method, parameters, datatype) { (result) in

            switch result {
            case .success(let data):
                 completionHandlerForAsyncImageDownload(.success(data))
            
            case .failure(let error):
                completionHandlerForAsyncImageDownload(.failure(error))
            }
        }
    }
}
