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
    
    public func downloadImageAsync(_ url: String) {
        
        NetworkManager.sharedInstance().downloadImagesAsync(url) { (imageData, error) in
            
            let image = UIImage(data: imageData)
            
            if (image != nil) {
                DispatchQueue.main.async() {
                    self.image = image
                }
            }
        }
    }
    
    public func downloadImageAsyncAndReturnImage(_ url: String, _ completionHandlerForImageDownload: @escaping (_ resultImage: UIImage, _ error: NSError?) -> Void) {
        
        NetworkManager.sharedInstance().downloadImagesAsync(url) { (imageData, error) in
            
            let image = UIImage(data: imageData)
            
            if (image != nil) {
                DispatchQueue.main.async() {
                    self.image = image
                    
                    if let result = image as UIImage? {
                        completionHandlerForImageDownload(result, nil)
                    }
                    
                }
            }
        }      
    }
}
