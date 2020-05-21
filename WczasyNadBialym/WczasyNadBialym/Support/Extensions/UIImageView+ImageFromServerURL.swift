//
//  UIImageView+ImageFromServerURL.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 24.03.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    public func downloadImageAsync(_ url: String, defaultImage image: String? = nil) {
        
        print(url)
        
        let networkController = NetworkController(session: URLSession.shared)
        networkController.downloadImagesAsync(url) { (result) in
            
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async() {
                    if let image = UIImage(data: imageData) {
                        self.image = image
                    }
                }
                
            case .failure(_):
                if let defaultImage = image as String? {
                    DispatchQueue.main.async() {
                        self.image = UIImage(named: defaultImage)
                        self.alpha = 0.5
                    }
                }
            }
        }
    }
    
    public func downloadImageAsyncAndReturnImage(_ url: String, _ completionHandlerForImageDownload: @escaping (_ resultImage: UIImage) -> Void) {
        
        let networkController = NetworkController(session: URLSession.shared)
        networkController.downloadImagesAsync(url) { (result) in
            
            switch result {
            case .success(let imageData):
                
                DispatchQueue.main.async() {
                    if let image = UIImage(data: imageData) {
                        self.image = image
                    }
                    completionHandlerForImageDownload(self.image!)
                }
                
            case .failure(let error):
                LogEventHandler.report(LogEventType.debug, "Unable to download na image", error.localizedDescription)
            }
        }
    }
}
