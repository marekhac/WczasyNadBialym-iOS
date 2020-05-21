//
//  API+Service.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 24.04.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

extension API {
    struct Service {
        
        // MARK: Controller Keys
        struct Controller {
            
            static let Services = "uslugi/"
        }
        
        // MARK: Methods
        struct Method {
            
            static let Categories = "kategorie-uslug"
            static let List = "lista"
            static let Details = "details"
        }
        
        // MARK: Method Keys
        struct ParameterKey {
            
            static let Kind = "typ"
            static let Id = "id"
        }
    }
}
