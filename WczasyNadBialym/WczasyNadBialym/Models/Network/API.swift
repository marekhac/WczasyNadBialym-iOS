//
//  NetworkProtocolConstants.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 20/05/2020.
//  Copyright © 2020 Marek Hać. All rights reserved.
//

import Foundation

struct API {
    
    static let AppId = Environment().config(PlistKey.AppId)
    
    // take different settings depends on configuration scheme
    
    static let Scheme = Environment().config(PlistKey.ApiScheme)
    static let Host = Environment().config(PlistKey.ApiHost)
    static let Path = Environment().config(PlistKey.ApiPath)

    struct Constants {

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
