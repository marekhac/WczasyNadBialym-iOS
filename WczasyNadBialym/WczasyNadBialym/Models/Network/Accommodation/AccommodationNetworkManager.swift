//
//  AccommodationNetworkManager.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 09.02.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation
import SVProgressHUD

extension NetworkManager {
    
    func getAccommodationListBasic (_ accomodationType : String, _ completionHandlerForAccomodations: @escaping (_ result: [AccommodationModel]?) -> Void) {
        
        let controller = Accommodation.Controllers.Accommodation
        let method  = Accommodation.Methods.ListBasic
        let parameters = [Accommodation.ParameterKeys.Kind : accomodationType]
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
        
        let controller = Accommodation.Controllers.Accommodation
        let method  = Accommodation.Methods.Details
        let parameters = [Accommodation.ParameterKeys.Id : accomodationId, Accommodation.ParameterKeys.Kind : accomodationType]
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
        
        let controller = Accommodation.Controllers.Accommodation
        let method  = Accommodation.Methods.Features
        let parameters = [Accommodation.ParameterKeys.Id : accomodationId]
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
        
        let controller = Accommodation.Controllers.Accommodation
        let method  = Accommodation.Methods.Pictures
        let parameters = [Accommodation.ParameterKeys.Id : accomodationId]
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
