//
//  AccommodationModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 21.02.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

struct AccommodationModel : Codable {
    
    let id : Int
    let name : String
    let price : String
    let imgMiniURL : String
    
    static func accommodationsFromResults(_ jsonData: Data) -> [AccommodationModel]? {
            
        let decoder = JSONDecoder()
        var accommodations = [AccommodationModel]()
        do {
            accommodations = try decoder.decode([AccommodationModel].self, from: jsonData)
        } catch let error {
            if(!ErrorDescriptionModel.unwrapFrom(jsonData)) {
                LogEventHandler.report(LogEventType.error, "Unable to parse Accommodation Model JSON", error.localizedDescription)
            }
        }
        
        return accommodations
    }
}
