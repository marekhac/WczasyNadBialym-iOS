//
//  WeatherNetworkManager.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 14.12.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

extension NetworkManager {

    func getCurrentMeasurement (_ completionHandlerForWeather: @escaping (_ result: WeatherModel?) -> Void) {
        
        let controller = Weather.Controllers.Weather
        let method  = Weather.Methods.CurrentMeasurement
        let parameters = [String: String]()
        let request = NSMutableURLRequest(url: buildURLFromParameters(controller, method, parameters)) as URLRequest
        
        downloadContent(with: request) { (result) in
            switch result {
            case .success(let content):
                let weatherData = content.parseData(using: WeatherModel.currentMeasurement)
                completionHandlerForWeather(weatherData as? WeatherModel)
            case .failure(let error):
                LogEventHandler.report(LogEventType.error, "Unable to download Weather Details", error.localizedDescription)
            }
        }
    }
}
