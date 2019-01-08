//
//  LogEventHandler.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 26.07.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation
import SVProgressHUD

struct LogEventHandler {
    
    static func report(_ logEventType: LogEventType = .info, _ message: String, _ description: String = "", displayWithHUD hud: Bool = false)
    {
        let debugLog = Bool(Environment().config(PlistKey.DebugLog)) ?? false
        let logEvent = logEventType.rawValue
        
        if (debugLog || (logEventType == .info)) {
            print ("\(logEvent) \(message) \n \(description)")
            
            if (hud) {
                SVProgressHUD.showError(withStatus: message)
            }
        }
    }
}
