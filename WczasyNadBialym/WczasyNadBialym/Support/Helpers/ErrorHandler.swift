//
//  ErrorHandler.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 26.07.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation
import SVProgressHUD

struct ErrorHandler {
    
    static func report(_ message: String, _ description: String, displayWithHUD hud: Bool = false)
    {
        print ("\n\("🚧") ERROR: \(message) \("😠") \(description) \("🚧")")
        
        if (hud) {
            SVProgressHUD.showError(withStatus: message)
        }
    }
}
