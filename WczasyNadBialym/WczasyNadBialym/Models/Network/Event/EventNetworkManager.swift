//
//  EventNetworkManager.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 09.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

extension NetworkManager {
       
    func getEventDetails (_ eventId : String, _ completionHandlerForEvents: @escaping (_ result: EventDetailModel, _ error: NSError?) -> Void) {
   
        /* 1. Specify parameters to build URL */
        
        let controller = EventURLParams.Controllers.Events
        let method  = EventURLParams.Methods.Details
        let parameters = [EventURLParams.ParameterKeys.Id : eventId]
        
        /* 2. Make the request */
        getRequest(controller, method, parameters) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                ErrorHandler.report("Unable to download Event Details", error.localizedDescription, displayWithHUD: true)
            } else {
                if let result = results {
                    if let list = EventDetailModel.detailsFromResults(result) {
                        completionHandlerForEvents(list, nil)
                    }
                }
            }
        }
    }
    
    func postEventDeltas (_ localIdsAndDeltas : [String : Any], _ completionHandlerForEventsDelta: @escaping (_ result: EventSyncModel, _ error: NSError?) -> Void) {
        
        /* Specify parameters to build URL */
        
        let controller = EventURLParams.Controllers.Events
        let method  = EventURLParams.Methods.Sync
        
        /* Make the request */
        
        postRequest(controller, method, localIdsAndDeltas) { (results, error) in
            
            if let error = error {
                ErrorHandler.report("Unable to Post Event Deltas", error.localizedDescription, displayWithHUD: true)
            } else {
                if let results = results {
                    if let eventsSections = EventSyncModel.eventSync(results) {
                        completionHandlerForEventsDelta(eventsSections, nil)
                    }
                }
            }
        }
        
    }

}
