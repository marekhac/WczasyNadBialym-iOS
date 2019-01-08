//
//  EventNetworkManager.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 09.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    func getEventSections (_ completionHandlerForEventsList: @escaping (_ result: [EventsInYearModel]?) -> Void) {
        
        let controller = Event.Controllers.Events
        let method = Event.Methods.List
        let parameters = [String: String]()
        
        let _ = taskForDownloadContent(controller, method, parameters) { (content, error) in
            if let error = error {
                LogEventHandler.report(LogEventType.error, "Unable to download Event Sections", error.localizedDescription, displayWithHUD: true)
            } else {
                let sections = content?.parseData(using: EventsInYearModel.eventsInYearFromResults)
                completionHandlerForEventsList(sections as? [EventsInYearModel])
            }
        }
    }
    
    func getEventDetails (_ eventId : String, _ completionHandlerForEvents: @escaping (_ result: EventDetailModel?) -> Void) {
        
        let controller = Event.Controllers.Events
        let method  = Event.Methods.Details
        let parameters = [Event.ParameterKeys.Id : eventId]
        
        let _ = taskForDownloadContent(controller, method, parameters) { (content, error) in
            if let error = error {
                LogEventHandler.report(LogEventType.error, "Unable to download Event Details", error.localizedDescription, displayWithHUD: true)
            } else {
                let details = content?.parseData(using: EventDetailModel.detailsFromResults)
                completionHandlerForEvents(details as? EventDetailModel)
            }
        }
    }
    
}
