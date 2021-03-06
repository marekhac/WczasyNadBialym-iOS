//
//  NetworkController+ImageDownload.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 20/05/2020.
//  Copyright © 2020 Marek Hać. All rights reserved.
//

import Foundation

extension NetworkController {
    
    func downloadImagesAsync (_ imagePath:String, _ completionHandlerForAsyncImageDownload: @escaping (Result<Data,Error>) -> Void) {
        
        let controller = imagePath
        let method  = ""
        let parameters = [String: String]()
        let datatype = DownloadedDataType.data
        
        let request = NSMutableURLRequest(url: buildURLFromParameters(controller, method, parameters, datatype)) as URLRequest
        
        downloadContent(with: request) { (result) in
            switch result {
            case .success(let data):
                completionHandlerForAsyncImageDownload(.success(data))
                
            case .failure(let error):
                completionHandlerForAsyncImageDownload(.failure(error))
            }
        }
    }
}
