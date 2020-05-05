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
        let debugMode = Bool(Environment().config(PlistKey.DebugMode)) ?? false
        let logEvent = logEventType.rawValue
        
        if (debugMode || (logEventType == .info)) {
            if (description != "") {
                print ("\(logEvent) \(message) --> \(description)")
            } else {
                print ("\(logEvent) \(message)")
            }
            
            if (hud) {
                SVProgressHUD.showError(withStatus: message)
            }
        }
    }
}
