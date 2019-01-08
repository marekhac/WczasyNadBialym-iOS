//
//  Environment.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 04/01/2019.
//  Copyright © 2019 Marek Hać. All rights reserved.
//
// inspired by Boudhayan Biswas's article
// https://medium.freecodecamp.org/managing-different-environments-and-configurations-for-ios-projects-7970327dd9c9

import Foundation

public enum PlistKey {
    case ApiScheme
    case ApiHost
    case ApiPath
    case DebugLog
    
    func value() -> String {
        switch self {
        case .ApiScheme:
            return "api_scheme"
        case .ApiHost:
            return "api_host"
        case .ApiPath:
            return "api_path"
        case .DebugLog:
            return "debug_log"
        }
    }
}
public struct Environment {
    
    fileprivate var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                fatalError("Plist file not found")
            }
        }
    }
    public func config(_ key: PlistKey) -> String {
        switch key {
        case .ApiScheme:
            return infoDict[PlistKey.ApiScheme.value()] as! String
        case .ApiHost:
            return infoDict[PlistKey.ApiHost.value()] as! String
        case .ApiPath:
            return infoDict[PlistKey.ApiPath.value()] as! String
        case .DebugLog:
            return infoDict[PlistKey.DebugLog.value()] as! String
        }
    }
}
