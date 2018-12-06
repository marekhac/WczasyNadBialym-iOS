//
//  AccommodationDetailsModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 16.03.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//
import Foundation

struct AccommodationDetailModel : Codable {
    
    let name: String
    let price: String
    let phone: String
    let email: String
    let www: String
    let description: String
    let miniImgURL : String
    let fullImgURL : String
    let gpsLat: Double
    let gpsLng: Double
    
    static func detailsFromResults(_ jsonData: Data) -> AccommodationDetailModel {
        
        var accommodationDetails : AccommodationDetailModel? = nil
        
        let decoder = JSONDecoder()
        do {
            accommodationDetails = try decoder.decode(AccommodationDetailModel.self, from: jsonData)
        } catch let error {
            ErrorHandler.report("Unable to parse Accommodation Details JSON", error.localizedDescription)
        }
        
        return accommodationDetails!
    }
}
