//
//  WeatherNetworkManager.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 14.12.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

extension NetworkManager {

    func getCurrentMeasurement (_ completionHandlerForWeather: @escaping (_ result: WeatherModel, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters to build URL */
        
        let controller = Weather.Controllers.Weather
        let method  = Weather.Methods.CurrentMeasurement
        let parameters = [String: String]()
    
    
        /* 2. Make the request */
        getRequest(controller, method, parameters) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                ErrorHandler.report("Unable to download Weather Details", error.localizedDescription, displayWithHUD: true)
            } else {
                if let result = results {
                    if let list = WeatherModel.currentMeasurement(result) {
                     completionHandlerForWeather(list, nil)
                    }
                }
            }
        }

    }
}
