//
//  WeatherModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 14.12.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

struct WeatherModel : Codable {

    let temp: Float
    let humidity: Int

    static func currentMeasurement(_ jsonData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        var weather : WeatherModel? = nil
        do {
            weather = try decoder.decode(WeatherModel.self, from: jsonData)
        } catch let error {
            ErrorHandler.report("Unable to parse Weather data JSON - ", error.localizedDescription)
        }
        
      return weather
    }
    
}
