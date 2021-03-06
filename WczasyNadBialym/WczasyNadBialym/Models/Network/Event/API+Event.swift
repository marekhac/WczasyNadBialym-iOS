//
//  EventEndpoint.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 09.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

extension API {
    struct Event {
        
        // MARK: Controller Keys
        struct Controller {
            
            static let Events = "imprezy/"
        }
        
        // MARK: Methods
        struct Method {
            
            static let List = "lista"
            static let Details = "details"
        }
        
        // MARK: Method Keys
        struct ParameterKey {
            static let Id = "id"
        }
        
        // MARK: JSON Response Keys
        
        struct JSONResponseKey {
            
            // MARK: List
            
            static let Id = "id"
            static let Name = "wydarzenie"
            static let Place = "miejsce"
            static let Date = "termin"
            static let Time = "godzina"
            
            // MARK: Details
            
            static let StartDate = "termin"
            static let StartTime = "godzina"
            static let Description = "opis"
            static let MedSizeImgUrl = "img_med_url"
            static let FullSizeImgUrl = "img_full_url"
        }
    }
}
