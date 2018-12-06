//
//  ServiceModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 26.04.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

struct ServiceModel : Codable {

    let id: Int
    let name: String
    let imgMiniURL: String
    
    static func servicesFromResults(_ jsonData: Data) -> [ServiceModel]? {
        
        let decoder = JSONDecoder()
        var services = [ServiceModel]()
        do {
            services = try decoder.decode([ServiceModel].self, from: jsonData)
        } catch let error {
            ErrorHandler.report("Unable to parse Service JSON", error.localizedDescription)
        }
        
        return services
    }
}
    
