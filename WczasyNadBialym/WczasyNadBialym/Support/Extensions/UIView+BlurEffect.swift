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
        
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            // always fill the view
            
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.insertSubview(blurEffectView, belowSubview: view)
            
        } else {
            self.backgroundColor = UIColor.white
        }
    }
    
    func addBlurSubview (at index: Int, style blurStyle: UIBlurEffect.Style = UIBlurEffect.Style.extraLight) {
        let blurEffect = UIBlurEffect(style: blurStyle)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.frame = self.bounds
    
        self.insertSubview(blurView, at: index)
    }
    
    func addBlurSubview (style blurStyle: UIBlurEffect.Style, tag customTagNumber: ViewTag = ViewTag.regular) {
        let blurEffect = UIBlurEffect(style: blurStyle)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.tag = customTagNumber.rawValue
        self.addSubview(blurView)
    }
    
    func addBlurSubview (style blurStyle: UIBlurEffect.Style, animation animationStyle:UIView.AnimationOptions) {
        UIView.transition(with: self, duration: 0.5, options: UIView.AnimationOptions.curveLinear,
                          animations: {
                                self.addBlurSubview(style: blurStyle)
                          }, completion: nil)
    }
}
