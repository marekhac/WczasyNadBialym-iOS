//
//  EventNetworkManager.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 09.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    func getEventsList(_ completionHandlerForEventsList: @escaping (_ result: [EventModel]?) -> Void) {
        
        let controller = Event.Controllers.Events
        let method = Event.Methods.List
        let parameters = [String: String]()
        let request = NSMutableURLRequest(url: buildURLFromParameters(controller, method, parameters)) as URLRequest
        
        downloadContent(with: request) { (result) in
            switch result {
            case .success(let content):
                let sections = content.parseData(using: EventModel.eventsFromResults)
                completionHandlerForEventsList(sections as? [EventModel])
            
            case .failure(let error):
                LogEventHandler.report(LogEventType.error, "Unable to download Event Sections", error.localizedDescription, displayWithHUD: true)
            }
        }
    }
    
    func getEventDetails (_ eventId : String, _ completionHandlerForEvents: @escaping (_ result: EventDetailModel?) -> Void) {
        
        let controller = Event.Controllers.Events
        let method  = Event.Methods.Details
        let parameters = [Event.ParameterKeys.Id : eventId]
     
        let request = NSMutableURLRequest(url: buildURLFromParameters(controller, method, parameters)) as URLRequest
        downloadContent(with: request) { (result) in
            
            switch result {
            case .success(let content):
                let details = content.parseData(using: EventDetailModel.detailsFromResults)
                completionHandlerForEvents(details as? EventDetailModel)
            
            case .failure(let error):
                LogEventHandler.report(LogEventType.error, "Unable to download Event Details", error.localizedDescription, displayWithHUD: true)
            }
        }
    }
}
