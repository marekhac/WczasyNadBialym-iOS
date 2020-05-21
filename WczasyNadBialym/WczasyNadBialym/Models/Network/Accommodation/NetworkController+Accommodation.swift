//
//  NetworkController+Accommodation.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 20/05/2020.
//  Copyright © 2020 Marek Hać. All rights reserved.
//

import Foundation
import SVProgressHUD

extension NetworkController {
    
    func getAccommodationListBasic (_ accomodationType : String, _ completionHandlerForAccomodations: @escaping (_ result: [AccommodationModel]?) -> Void) {
        
        let controller = API.Accommodation.Controller.Accommodation
        let method  = API.Accommodation.Method.ListBasic
        let parameters = [API.Accommodation.ParameterKey.Kind : accomodationType]
        let request = NSMutableURLRequest(url: buildURLFromParameters(controller, method, parameters)) as URLRequest
        
        downloadContent(with: request) { (result) in
            switch result {
            case .success(let content):
                let list = content.parseData(using: AccommodationModel.accommodationsFromResults)
                completionHandlerForAccomodations(list as? [AccommodationModel])
                
            case .failure(let error):
                LogEventHandler.report(LogEventType.error, "Unable to download Accommodation List", error.localizedDescription, displayWithHUD: true)
            }
        }
    }
    
    func getAccommodationDetails (_ accomodationId : String, _ accomodationType : String, _ completionHandlerForDetails: @escaping (_ result: AccommodationDetailModel?) -> Void) {
        
        let controller = API.Accommodation.Controller.Accommodation
        let method  = API.Accommodation.Method.Details
        let parameters = [API.Accommodation.ParameterKey.Id : accomodationId, API.Accommodation.ParameterKey.Kind : accomodationType]
        let request = NSMutableURLRequest(url: buildURLFromParameters(controller, method, parameters)) as URLRequest
        
        downloadContent(with: request) { (result) in
            switch result {
            case .success(let content):
                let details = content.parseData(using: AccommodationDetailModel.detailsFromResults)
                completionHandlerForDetails(details as? AccommodationDetailModel)
            case .failure(let error):
                LogEventHandler.report(LogEventType.error, "Unable to download Accommodaiton Details", error.localizedDescription, displayWithHUD: true)
            }
        }
    }
    
    func getAccommodationProperties (_ accomodationId : String, _ completionHandlerForProperties: @escaping (_ result: AccommodationPropertiesModel?) -> Void) {
        
        let controller = API.Accommodation.Controller.Accommodation
        let method  = API.Accommodation.Method.Features
        let parameters = [API.Accommodation.ParameterKey.Id : accomodationId]
        let request = NSMutableURLRequest(url: buildURLFromParameters(controller, method, parameters)) as URLRequest
        
        downloadContent(with: request) { (result) in
            switch result {
            case .success(let content):
                let properties = content.parseData(using: AccommodationPropertiesModel.propertiesFromResults)
                completionHandlerForProperties(properties as? AccommodationPropertiesModel)
            case .failure(let error):
                LogEventHandler.report(LogEventType.error, "Unable to download Accommodaiton Properties JSON", error.localizedDescription)
            }
        }
    }
    
    func getAccommodationPictures (_ accomodationId : String, _ completionHandlerForPictures: @escaping (_ result: AccommodationGalleryModel?) -> Void) {
        
        let controller = API.Accommodation.Controller.Accommodation
        let method  = API.Accommodation.Method.Pictures
        let parameters = [API.Accommodation.ParameterKey.Id : accomodationId]
        let request = NSMutableURLRequest(url: buildURLFromParameters(controller, method, parameters)) as URLRequest
        
        downloadContent(with: request) { (result) in
            switch result {
            case .success(let content):
                let pictures = content.parseData(using: AccommodationGalleryModel.picturesFromResults)
                
                // if pictures is nil, we will handle it in completionHandlerForPictures
                
                completionHandlerForPictures(pictures as? AccommodationGalleryModel)
            case .failure(let error):
                LogEventHandler.report(LogEventType.error, "Unable to download Accommodaiton Pictures JSON", error.localizedDescription)
                
            }
        }
    }
}

