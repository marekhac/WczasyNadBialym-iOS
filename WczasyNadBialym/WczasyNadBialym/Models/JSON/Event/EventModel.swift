//
//  EventModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 09.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

    struct EventModel : Codable {
        let id : Int
        let name : String
        let place : String
        let date : Date
    

    static func eventsFromResults(_ jsonData: Data) -> [EventModel]? {
    
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Date.Formatter.customDateAndHourFormat)
        
        var events = [EventModel]()
        do {
            events = try decoder.decode([EventModel].self, from: jsonData)
        } catch let error {
            if(!ErrorDescriptionModel.unwrapFrom(jsonData)) {
                LogEventHandler.report(LogEventType.error, "Unable to parse JSON for Events List", error.localizedDescription)
            }
        }
        
        return events
        
    }
}

