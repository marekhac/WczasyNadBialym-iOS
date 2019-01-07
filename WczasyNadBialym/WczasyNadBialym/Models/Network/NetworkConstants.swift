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
        
        // take different settings depends on configuration scheme
        
        static let ApiScheme = Environment().config(PlistKey.ApiScheme)
        static let ApiHost = Environment().config(PlistKey.ApiHost)
        static let ApiPath = Environment().config(PlistKey.ApiPath)
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
