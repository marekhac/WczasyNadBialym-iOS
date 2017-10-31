//
//  AccommodationNetworkManager.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 09.02.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    func getAccommodationListBasic (_ accomodationType : String, _ completionHandlerForAccomodations: @escaping (_ result: [AccommodationModel], _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters to build URL */
        
        let controller = Accommodation.Controllers.Accommodation
        let method  = Accommodation.Methods.ListBasic
        let parameters = [Accommodation.ParameterKeys.Kind : accomodationType]
        
        /* 2. Make the request */
        
        let _ = taskForDownloadContent(controller, method, parameters) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                ErrorHandler.report("Unable to download Accommodaiton List JSON", error.localizedDescription)
            } else {
                if let result = results {
                    let list = AccommodationModel.accommodationsFromResults(result)
                    completionHandlerForAccomodations(list, nil)
                }
            }
        }
    }
    
    func getAccommodationDetails (_ accomodationId : String, _ accomodationType : String, _ completionHandlerForAccomodations: @escaping (_ result: AccommodationDetailModel, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters to build URL */
        
        let controller = Accommodation.Controllers.Accommodation
        let method  = Accommodation.Methods.Details
        let parameters = [Accommodation.ParameterKeys.Id : accomodationId, Accommodation.ParameterKeys.Kind : accomodationType]
        
        // let parameters = [String: String]
        
        /* 2. Make the request */
        let _ = taskForDownloadContent(controller, method, parameters) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                ErrorHandler.report("Unable to download Accommodaiton Details JSON", error.localizedDescription)
            } else {
                //if let result = results as? [String:AnyObject] {
                if let result = results {
                    let list = AccommodationDetailModel.detailsFromResults(result)
                    completionHandlerForAccomodations(list, nil)
                }
            }
        }
    }
    
    func getAccommodationProperties (_ accomodationId : String, _ completionHandlerForProperties: @escaping (_ result: AccommodationPropertiesModel, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters to build URL */
        
        let controller = Accommodation.Controllers.Accommodation
        let method  = Accommodation.Methods.Features
        let parameters = [Accommodation.ParameterKeys.Id : accomodationId]
        
        // let parameters = [String: String]
        
        /* 2. Make the request */
        let _ = taskForDownloadContent(controller, method, parameters) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                ErrorHandler.report("Unable to download Accommodaiton Properties JSON", error.localizedDescription)
            } else {
                if let result = results {
                    let list = AccommodationPropertiesModel.propertiesFromResults(result)
                    completionHandlerForProperties(list, nil)
                }
            }
        }
    }
    
    func getAccommodationPictures (_ accomodationId : String, _ completionHandlerForAccomodations: @escaping (_ result: AccommodationGalleryModel?, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters to build URL */
        
        let controller = Accommodation.Controllers.Accommodation
        let method  = Accommodation.Methods.Pictures
        let parameters = [Accommodation.ParameterKeys.Id : accomodationId]
        
        // let parameters = [String: String]
        
        /* 2. Make the request */
        let _ = taskForDownloadContent(controller, method, parameters) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            
            if let error = error {
                ErrorHandler.report("Unable to download Accommodaiton Pictures JSON", error.localizedDescription)
            } else {
                if let result = results {
                    let list = AccommodationGalleryModel.picturesFromResults(result)
                    completionHandlerForAccomodations(list, nil)
                }
            }
        }
    }
}
