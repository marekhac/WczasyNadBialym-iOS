//
//  AccommodationGalleryModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 22.03.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

struct AccommodationGalleryModel : Codable {

    let dirMiniPictures: String
    let dirMainPicture: String
    let dirLargePictures: String
    let arrayOfPictures : [String]
    let mainImgMini: String
    let mainImgFull: String
    
    static func picturesFromResults(_ jsonData: Data) -> AccommodationGalleryModel? {
        
        var gallery : AccommodationGalleryModel? = nil
        
        let decoder = JSONDecoder()
        do {
            gallery = try decoder.decode(AccommodationGalleryModel.self, from: jsonData)
        } catch let error {
            ErrorHandler.report("Unable to parse Accommodation Gallery JSON", error.localizedDescription)
        }
        
        return gallery // there might be no pictures in the gallery
    }
    
}
