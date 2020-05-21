//
//  API+Accommodation.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 21.02.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

extension API {
    struct Accommodation {
        
        // MARK: Controller Keys
        struct Controller {
            
            static let Accommodation = "noclegi/"
        }
        
        // MARK: Methods
        struct Method {
            
            static let ListBasic = "lista"
            static let Details = "details"
            static let Pictures = "pobierz-liste-zdjec"
            static let Features = "wyposazenie"
        }
        
        // MARK: Method Keys
        struct ParameterKey {
            
            static let Kind = "typ"
            static let Id = "id"
        }    
    }
}
