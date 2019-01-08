//
//  ServiceWebManager.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 24.04.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    func getServiceCategories (_ completionHandlerForServices: @escaping (_ result: [ServiceCategoryModel]?) -> Void) {
        
        let controller = Service.Controllers.Services
        let method  = Service.Methods.Categories
        let parameters = [String: String]()
        
        let _ = taskForDownloadContent(controller, method, parameters) { (content, error) in
            if let error = error {
                LogEventHandler.report(LogEventType.error, "Unable to download Serivce Categories", error.localizedDescription)
            } else {
                let categories = content?.parseData(using: ServiceCategoryModel.servicesFromResults)
                completionHandlerForServices(categories as? [ServiceCategoryModel])
            }
        }
    }
    
    func getServiceList (_ serviceType : String, _ completionHandlerForServices: @escaping (_ result: [ServiceModel]?) -> Void) {
        
        let controller = Service.Controllers.Services
        let method  = Service.Methods.List
        let parameters = [Service.ParameterKeys.Kind : serviceType]
        // let parameters = [String: String]
        
        let _ = taskForDownloadContent(controller, method, parameters) { (content, error) in
            if let error = error {
                LogEventHandler.report(LogEventType.error, "Unable to download Serivce List", error.localizedDescription, displayWithHUD: true)
            } else {
                let list = content?.parseData(using: ServiceModel.servicesFromResults)
                completionHandlerForServices(list as? [ServiceModel])
            }
        }
    }
    
    func getServiceDetails (_ eventId : String, _ completionHandlerForEvents: @escaping (_ result: ServiceDetailModel?) -> Void) {
        
        let controller = Service.Controllers.Services
        let method  = Service.Methods.Details
        let parameters = [Service.ParameterKeys.Id : eventId]
        
        let _ = taskForDownloadContent(controller, method, parameters) { (content, error) in
            if let error = error {
                LogEventHandler.report(LogEventType.error, "Unable to download Service Details", error.localizedDescription, displayWithHUD: true)
            } else {
                let details = content?.parseData(using: ServiceDetailModel.detailsFromResults)
                completionHandlerForEvents(details as? ServiceDetailModel)
            }
        }
    }
    
}
