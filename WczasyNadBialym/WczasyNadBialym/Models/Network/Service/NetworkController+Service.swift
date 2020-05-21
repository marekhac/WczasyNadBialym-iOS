//
//  NetworkController+Service.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 20/05/2020.
//  Copyright © 2020 Marek Hać. All rights reserved.
//

import Foundation

extension NetworkController {
    
    func getServiceCategories (_ completionHandlerForServices: @escaping (_ result: [ServiceCategoryModel]?) -> Void) {
        
        let controller = API.Service.Controller.Services
        let method  = API.Service.Method.Categories
        let parameters = [String: String]()
        let request = NSMutableURLRequest(url: buildURLFromParameters(controller, method, parameters)) as URLRequest
        
        downloadContent(with: request) { (result) in
            switch result {
                
            case .success(let content):
                let categories = content.parseData(using: ServiceCategoryModel.servicesFromResults)
                completionHandlerForServices(categories as? [ServiceCategoryModel])
                
            case .failure(let error):
                LogEventHandler.report(LogEventType.error, "Unable to download Serivce Categories", error.localizedDescription)
            }
        }
    }
    
    func getServiceList (_ serviceType : String, _ completionHandlerForServices: @escaping (_ result: [ServiceModel]?) -> Void) {
        
        let controller = API.Service.Controller.Services
        let method  = API.Service.Method.List
        let parameters = [API.Service.ParameterKey.Kind : serviceType]
        
        let request = NSMutableURLRequest(url: buildURLFromParameters(controller, method, parameters)) as URLRequest
        
        downloadContent(with: request) { (result) in
            switch result {
            case .success(let content):
                let list = content.parseData(using: ServiceModel.servicesFromResults)
                completionHandlerForServices(list as? [ServiceModel])
                
            case .failure(let error):
                LogEventHandler.report(LogEventType.error, "Unable to download Serivce List", error.localizedDescription, displayWithHUD: true)
            }
        }
    }
    
    func getServiceDetails (_ eventId : String, _ completionHandlerForEvents: @escaping (_ result: ServiceDetailModel?) -> Void) {
        
        let controller = API.Service.Controller.Services
        let method  = API.Service.Method.Details
        let parameters = [API.Service.ParameterKey.Id : eventId]
        let request = NSMutableURLRequest(url: buildURLFromParameters(controller, method, parameters)) as URLRequest
        
        downloadContent(with: request) { (result) in
            switch result {
            case .success(let content):
                let details = content.parseData(using: ServiceDetailModel.detailsFromResults)
                completionHandlerForEvents(details as? ServiceDetailModel)
                
            case .failure(let error):
                LogEventHandler.report(LogEventType.error, "Unable to download Service Details", error.localizedDescription, displayWithHUD: true)
            }
        }
    }
}
