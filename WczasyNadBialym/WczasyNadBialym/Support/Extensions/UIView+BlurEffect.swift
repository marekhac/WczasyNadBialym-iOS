//
//  UIView+BlurEffect.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 09.10.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addBlurSubview (below view: UIView) {
        // Do any additional setup after loading the view.
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            // always fill the view
            
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.insertSubview(blurEffectView, belowSubview: view)
            
        } else {
            self.backgroundColor = UIColor.white
        }
    }
    
    func addBlurSubview (at index: Int) {
        let extraLightBlur = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurView = UIVisualEffectView(effect: extraLightBlur)
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.frame = self.bounds
    
        self.insertSubview(blurView, at: index)
    }
    
    func addBlurSubview (style blurStyle: UIBlurEffectStyle) {
        let blurEffect = UIBlurEffect(style: blurStyle)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurView)
    }
}
