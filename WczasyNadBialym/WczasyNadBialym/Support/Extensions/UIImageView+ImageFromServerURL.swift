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
        
        NetworkManager.sharedInstance().downloadImagesAsync(url) { (imageData, error) in
    
            if let downloadedImageData = imageData as Data? {
                DispatchQueue.main.async() {
                    self.image = UIImage(data: downloadedImageData)
                }
            }
            else {
                if let defaultImage = image as String? {
                    DispatchQueue.main.async() {
                        self.image = UIImage(named: defaultImage)
                        self.alpha = 0.5
                    }
                }
            }
        }
    }
    
    public func downloadImageAsyncAndReturnImage(_ url: String, _ completionHandlerForImageDownload: @escaping (_ resultImage: UIImage, _ error: NSError?) -> Void) {
        
        NetworkManager.sharedInstance().downloadImagesAsync(url) { (imageData, error) in
            
            if let downloadedImageData = imageData as Data? {
                
                DispatchQueue.main.async() {
                    self.image = UIImage(data: downloadedImageData)
                    
                    completionHandlerForImageDownload(self.image!, nil)
                }
            }
        }
    }
}
