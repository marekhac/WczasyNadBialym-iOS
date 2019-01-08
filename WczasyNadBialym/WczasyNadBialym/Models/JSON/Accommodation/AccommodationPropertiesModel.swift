//
//  AccommodationPropertiesModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 28.03.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

struct AccommodationPropertiesModel : Codable {

    let features : [String]
    let advantages : [String]

    static func propertiesFromResults(_ jsonData: Data) -> AccommodationPropertiesModel {
        
        var properties : AccommodationPropertiesModel? = nil
        
        let decoder = JSONDecoder()
        do {
            properties = try decoder.decode(AccommodationPropertiesModel.self, from: jsonData)
        } catch {
            if(!ErrorModel.unwrapFrom(jsonData)) {
                LogEventHandler.report(LogEventType.error, "Unable to parse Accommodation Properties JSON", error.localizedDescription)
            }
        }
        
        return properties!
    }
}
