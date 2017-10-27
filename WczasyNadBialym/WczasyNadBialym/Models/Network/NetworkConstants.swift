//
//  NetworkConstants.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 08.02.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    struct Constants {

        static let AppId = "YOUR_APPID";
        
        // localhost
        
        static let ApiScheme = "http://"
        static let ApiHost = "portal-dev:8888/"
        static let ApiPath = "api/"
        
        // live
        
        // static let ApiScheme = "http://"
        // static let ApiHost = "wczasynadbialym/"
        // static let ApiPath = "api/"
    }
    
    // MARK: Method Keys
    struct ParameterKeys {
        
        static let AccommodationType = "typ"
    }
    
    // MARK: Controller Keys
    struct Controllers {
        
        static let Accommodation = "noclegi/"
    }
    
    // MARK: Methods
    struct Methods {
        
        // MARK: List
          static let AccommodationListBasic = "lista"
    }
}
