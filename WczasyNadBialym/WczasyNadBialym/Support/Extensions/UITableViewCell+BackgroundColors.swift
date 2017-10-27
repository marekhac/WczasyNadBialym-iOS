//
//  UITableViewCell+BackgroundColors.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 13.10.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    func selectedBackgroundColor(_ color: UIColor) {
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = color
        self.selectedBackgroundView = bgColorView
    }
}
