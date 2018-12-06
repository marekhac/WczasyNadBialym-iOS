//
//  ServiceDetailModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 09.11.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

struct ServiceDetailModel : Codable {
    
    let name: String
    let street: String
    let city: String
    let phone: String
    let description: String
    let miniImgURL : String
    let gpsLat: Double
    let gpsLng: Double
    
    static func detailsFromResults(_ jsonData : Data) -> ServiceDetailModel? {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Date.Formatter.customDateAndHourFormat)
        
        var details : ServiceDetailModel? = nil
        do {
            details = try decoder.decode(ServiceDetailModel.self, from: jsonData)
        } catch let error {
            ErrorHandler.report("Unble to parse Service Detail JSON", error.localizedDescription)
        }
        
        return details
    }
}
