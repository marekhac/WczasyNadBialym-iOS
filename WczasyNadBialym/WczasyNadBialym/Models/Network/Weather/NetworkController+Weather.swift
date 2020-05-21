//
//  NetworkController+Weather.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 20/05/2020.
//  Copyright © 2020 Marek Hać. All rights reserved.
//

import Foundation

extension NetworkController {

    func getCurrentMeasurement (_ completionHandlerForWeather: @escaping (_ result: WeatherModel?) -> Void) {
        
        let controller = API.Weather.Controller.Weather
        let method = API.Weather.Method.CurrentMeasurement

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
