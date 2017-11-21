//
//  EventNetworkManager.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 09.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    func getEventSections (_ completionHandlerForEventsList: @escaping (_ result: [EventsInYearModel], _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters to build URL */
        
        
        let controller = Event.Controllers.Events
        let method = Event.Methods.List
        let parameters = [String: String]()
        
        /* 2. Make the request */
        let _ = taskForDownloadContent(controller, method, parameters) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                ErrorHandler.report("Unable to download Event Sections", error.localizedDescription, displayWithHUD: true)
            } else {
                if let results = results {
                    let eventsSections = EventsInYearModel.eventsInYearFromResults(results)
                        completionHandlerForEventsList(eventsSections, nil)
                }
            }
        }
    }
    
    func getEventDetails (_ eventId : String, _ completionHandlerForEvents: @escaping (_ result: EventDetailModel, _ error: NSError?) -> Void) {
   
        /* 1. Specify parameters to build URL */
        
        let controller = Event.Controllers.Events
        let method  = Event.Methods.Details
        let parameters = [Event.ParameterKeys.Id : eventId]
        
        /* 2. Make the request */
        let _ = taskForDownloadContent(controller, method, parameters) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                ErrorHandler.report("Unable to download Event Details", error.localizedDescription, displayWithHUD: true)
            } else {
                if let result = results {
                    let list = EventDetailModel.detailsFromResults(result)
                    completionHandlerForEvents(list, nil)
                }
            }
        }
    }
    
}
