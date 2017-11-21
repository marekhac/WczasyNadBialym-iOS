//
//  ServiceWebManager.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 24.04.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    func getServiceCategories (_ completionHandlerForServices: @escaping (_ result: [ServiceCategoryModel], _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters to build URL */
        
        let controller = Service.Controllers.Services
        let method  = Service.Methods.Categories
        let parameters = [String: String]()
        
        /* 2. Make the request */
        let _ = taskForDownloadContent(controller, method, parameters) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                ErrorHandler.report("Unable to download Serivce Categories", error.localizedDescription)
            } else {
                if let result = results {
                    let list = ServiceCategoryModel.servicesFromResults(result)
                    completionHandlerForServices(list, nil)
                }
            }
        }
    }
    
    func getServiceList (_ serviceType : String, _ completionHandlerForServices: @escaping (_ result: [ServiceModel], _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters to build URL */
        
        let controller = Service.Controllers.Services
        let method  = Service.Methods.List
        let parameters = [Service.ParameterKeys.Kind : serviceType]
        
        // let parameters = [String: String]
        
        /* 2. Make the request */
        let _ = taskForDownloadContent(controller, method, parameters) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                ErrorHandler.report("Unable to download Serivce List", error.localizedDescription, displayWithHUD: true)
            } else {
                if let result = results {
                    let list = ServiceModel.servicesFromResults(result)
                    completionHandlerForServices(list, nil)
                }
            }
        }
    }
    
    func getServiceDetails (_ eventId : String, _ completionHandlerForEvents: @escaping (_ result: ServiceDetailModel?, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters to build URL */
        
        let controller = Service.Controllers.Services
        let method  = Service.Methods.Details
        let parameters = [Service.ParameterKeys.Id : eventId]
        
        /* 2. Make the request */
        let _ = taskForDownloadContent(controller, method, parameters) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                ErrorHandler.report("Unable to download Service Details", error.localizedDescription, displayWithHUD: true)
                completionHandlerForEvents(nil, error)
            } else {
                if let result = results {
                    let list = ServiceDetailModel.detailsFromResults(result)
                    completionHandlerForEvents(list, nil)
                }
            }
        }
    }
    
}
