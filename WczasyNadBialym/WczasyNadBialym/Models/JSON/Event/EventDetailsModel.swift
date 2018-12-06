//
//  EventDetailsModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 30.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//
import Foundation

struct EventDetailModel : Codable {
    
    let name: String
    let place: String
    let date : Date
    let description: String
    let imgMedURL : String
    let imgFullURL : String
    
    static func detailsFromResults(_ jsonData : Data) -> EventDetailModel? {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Date.Formatter.customDateAndHourFormat)
        
        var details : EventDetailModel? = nil
        do {
            details = try decoder.decode(EventDetailModel.self, from: jsonData)
       //     details?.date.getHourAndMinutes()
            
        } catch let error {
            ErrorHandler.report("Unable to parse Event Detail JSON", error.localizedDescription)
        }
        
        return details
    }
}
