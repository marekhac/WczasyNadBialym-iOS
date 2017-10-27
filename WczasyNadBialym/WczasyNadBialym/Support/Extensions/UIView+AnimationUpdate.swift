//
//  UIView+AnimationUpdate.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 17.10.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func updateLayoutWithAnimation(andDuration durationInSec: TimeInterval) {
        UIView.animate(withDuration: durationInSec) {
            self.layoutIfNeeded()
        }
    }
}
