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
    case AppId
    case ApiScheme
    case ApiHost
    case ApiPath
    case DebugLog
    case AdUnitId
    case AppCenterId
    
    func value() -> String {
        switch self {
        case .AppId:
            return "app_id"
        case .ApiScheme:
            return "api_scheme"
        case .ApiHost:
            return "api_host"
        case .ApiPath:
            return "api_path"
        case .DebugLog:
            return "debug_log"
        case .AdUnitId:
            return "ad_unit_id"
        case .AppCenterId:
            return "app_center_id"
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
        case .AppId:
            return infoDict[PlistKey.AppId.value()] as! String
        case .ApiScheme:
            return infoDict[PlistKey.ApiScheme.value()] as! String
        case .ApiHost:
            return infoDict[PlistKey.ApiHost.value()] as! String
        case .ApiPath:
            return infoDict[PlistKey.ApiPath.value()] as! String
        case .DebugLog:
            return infoDict[PlistKey.DebugLog.value()] as! String
        case .AdUnitId:
            return infoDict[PlistKey.AdUnitId.value()] as! String
        case .AppCenterId:
            return infoDict[PlistKey.AppCenterId.value()] as! String
        }
    }
}
