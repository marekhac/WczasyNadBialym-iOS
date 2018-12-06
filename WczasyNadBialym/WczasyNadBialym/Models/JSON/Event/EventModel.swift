//
//  EventModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 09.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

struct EventsInYearModel : Codable {
    struct EventModel : Codable {
        let id : Int
        let name : String
        let place : String
        let date : Date
        
    }
    let year: Int
    let events: [EventModel]
    
    static func eventsInYearFromResults(_ jsonData: Data) -> [EventsInYearModel]? {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Date.Formatter.customDateAndHourFormat)
        
        var eventsInYear = [EventsInYearModel]()
        do {
            eventsInYear = try decoder.decode([EventsInYearModel].self, from: jsonData)
        } catch let error {
            ErrorHandler.report("Unable to parse Events in Year", error.localizedDescription)
        }
        
        return eventsInYear
    }
}

