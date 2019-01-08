//
//  LogEventType.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 07/01/2019.
//  Copyright © 2019 Marek Hać. All rights reserved.
//

import Foundation

enum LogEventType: String {
    case error = "[‼️] ERROR:"
    case info = "[ℹ️] INFO:" // should be printed even when debug log mode is disabled
    case debug = "[💬] DEBUG:"
    case verbose = "[🔬] VERBOSE:"
    case warning = "[⚠️] WARNING:"
    case fire = "[🔥] FIRE:"
}

