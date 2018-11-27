//
//  EventSyncModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 26.11.2018.
//  Copyright © 2018 Marek Hać. All rights reserved.
//

import Foundation

struct EventSyncModel : Codable {
    
    let update: [EventModel]
    let delete: [Int]
    
    static func eventSync(_ jsonData: Data) -> EventSyncModel? {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Date.Formatter.customDateAndHourFormat)
        
        var eventSync : EventSyncModel? = nil
        do {
            eventSync = try decoder.decode(EventSyncModel.self, from: jsonData)
        } catch {
            if(!ErrorModel.unwrapFrom(jsonData)) {
                ErrorHandler.report("Unable to parseEvent Sync JSON", error.localizedDescription)
            }
        }
        
        return eventSync
    }
}
