//
//  ErrorHandler.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 26.07.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

struct ErrorHandler {
    
    static func report(_ title: String, _ message: String)
    {
        print ("ERROR: \(title) - \(message)")
    }
}
