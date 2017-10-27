//
//  UITextView+HeightUpdate.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 17.10.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    
    func updateHeight(of heighConstraint: NSLayoutConstraint) {
        
        let size = self.sizeThatFits(CGSize(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if size.height != heighConstraint.constant && size.height > self.frame.size.height{
            heighConstraint.constant = size.height
            self.setContentOffset(CGPoint.zero, animated: false)
        }
    }
}

