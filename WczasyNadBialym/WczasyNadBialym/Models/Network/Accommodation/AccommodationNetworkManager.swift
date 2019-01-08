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
    
    func getAccommodationListBasic (_ accomodationType : String, _ completionHandlerForAccomodations: @escaping (_ result: [AccommodationModel], _ error: NSError?) -> Void) {
        
        let controller = Accommodation.Controllers.Accommodation
        let method  = Accommodation.Methods.ListBasic
        let parameters = [Accommodation.ParameterKeys.Kind : accomodationType]
        
        let _ = taskForDownloadContent(controller, method, parameters) { (content, error) in
            if let error = error {
                LogEventHandler.report(LogEventType.error, "Unable to download Accommodation List", error.localizedDescription, displayWithHUD: true)
            } else {
                if let list = content?.parseData(using: AccommodationModel.accommodationsFromResults) {
                    completionHandlerForAccomodations(list as! [AccommodationModel], nil)
                }
            }
        }
    }
    
    func getAccommodationDetails (_ accomodationId : String, _ accomodationType : String, _ completionHandlerForDetails: @escaping (_ result: AccommodationDetailModel, _ error: NSError?) -> Void) {
        
        let controller = Accommodation.Controllers.Accommodation
        let method  = Accommodation.Methods.Details
        let parameters = [Accommodation.ParameterKeys.Id : accomodationId, Accommodation.ParameterKeys.Kind : accomodationType]
        // let parameters = [String: String]
        
        let _ = taskForDownloadContent(controller, method, parameters) { (content, error) in
            if let error = error {
                LogEventHandler.report(LogEventType.error, "Unable to download Accommodaiton Details", error.localizedDescription, displayWithHUD: true)
            } else {
                if let details = content?.parseData(using: AccommodationDetailModel.detailsFromResults) {
                    completionHandlerForDetails(details as! AccommodationDetailModel, nil)
                }
            }
        }
    }
    
    func getAccommodationProperties (_ accomodationId : String, _ completionHandlerForProperties: @escaping (_ result: AccommodationPropertiesModel, _ error: NSError?) -> Void) {
        
        let controller = Accommodation.Controllers.Accommodation
        let method  = Accommodation.Methods.Features
        let parameters = [Accommodation.ParameterKeys.Id : accomodationId]
        // let parameters = [String: String]
        
        let _ = taskForDownloadContent(controller, method, parameters) { (content, error) in
            if let error = error {
                LogEventHandler.report(LogEventType.error, "Unable to download Accommodaiton Properties JSON", error.localizedDescription)
            } else {
                if let properties = content?.parseData(using: AccommodationPropertiesModel.propertiesFromResults) {
                    completionHandlerForProperties(properties as! AccommodationPropertiesModel, nil)
                }
            }
        }
    }
    
    func getAccommodationPictures (_ accomodationId : String, _ completionHandlerForPictures: @escaping (_ result: AccommodationGalleryModel?, _ error: NSError?) -> Void) {
        
        let controller = Accommodation.Controllers.Accommodation
        let method  = Accommodation.Methods.Pictures
        let parameters = [Accommodation.ParameterKeys.Id : accomodationId]
        // let parameters = [String: String]
        
        let _ = taskForDownloadContent(controller, method, parameters) { (content, error) in
            if let error = error {
                LogEventHandler.report(LogEventType.error, "Unable to download Accommodaiton Pictures JSON", error.localizedDescription)
            } else {
                if let pictures = content?.parseData(using: AccommodationGalleryModel.picturesFromResults) {
                    completionHandlerForPictures(pictures as? AccommodationGalleryModel, nil)
                }
            }
        }
    }
}
