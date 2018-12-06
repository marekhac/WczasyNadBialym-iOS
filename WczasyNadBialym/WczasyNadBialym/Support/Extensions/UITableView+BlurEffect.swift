//
//  UITableView+BlurEffect.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 13.10.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func addBlurSubview(image imageName: String) {
        // setup background
        
        let backgroundImage = UIImage(named: imageName)
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFill
        self.backgroundView = imageView
        self.backgroundColor = .lightGray
        
        // no lines where there aren't cells
        
        self.tableFooterView = UIView(frame: CGRect.zero)
        
        // add blur
        
        imageView.addBlurSubview(style: UIBlurEffect.Style.light)
    }
}
