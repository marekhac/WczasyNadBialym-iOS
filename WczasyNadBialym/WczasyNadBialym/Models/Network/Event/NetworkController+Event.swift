//
//  NetworkController+Event.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 20/05/2020.
//  Copyright © 2020 Marek Hać. All rights reserved.
//

import Foundation

extension NetworkController {
    
    func getEventsList(_ completionHandlerForEventsList: @escaping (_ result: [EventModel]?) -> Void) {
        
        let controller = API.Event.Controller.Events
        let method = API.Event.Method.List
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
        
        let controller = API.Event.Controller.Events
        let method  = API.Event.Method.Details
        let parameters = [API.Event.ParameterKey.Id : eventId]
     
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

