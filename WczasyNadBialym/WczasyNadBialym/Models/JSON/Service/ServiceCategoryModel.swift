//
//  ServiceCategoryModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 25.04.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

struct ServiceCategoryModel : Codable {
    
    let shortName: String
    let longName: String
    let id: Int
    let type: String
    
    // init made for local initialization of Services (not downloaded from the server)
    
    init(shortName: String, longName: String) {
        self.shortName = shortName
        self.longName = longName
        self.id = 0
        self.type = ""
    }

    static func servicesFromResults(_ jsonData : Data) -> [ServiceCategoryModel]? {
        
        let decoder = JSONDecoder()
        var categories = [ServiceCategoryModel]()
        do {
            categories = try decoder.decode([ServiceCategoryModel].self, from: jsonData)
        } catch let error {
            ErrorHandler.report("Unable to parse Service Categories JSON", error.localizedDescription)
        }
        
        return categories
    }
}
