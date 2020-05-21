//
//  AccommodationDetailsViewModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 18.09.2018.
//  Copyright © 2018 Marek Hać. All rights reserved.
//

import Foundation

class AccommodationDetailsViewModel {
    
    private lazy var networkController = NetworkController(session: URLSession.shared)
    
    var updateDetailViewClosure: (()->())?
    var updateGalleryViewClosure: (()->())?
    var updatePropertiesViewClosure: (()->())?
    
    // MARK: update closures
    
    private var accommodationDetails: AccommodationDetailModel? {
        didSet {
            self.updateDetailViewClosure?()
        }
    }
    
    private var accommodationGallery: AccommodationGalleryModel? {
        didSet {
            self.updateGalleryViewClosure?()
        }
    }
    
    private var accommodationProperties: AccommodationPropertiesModel? {
        didSet {
            self.updatePropertiesViewClosure?()
        }
    }
    
    // MARK: getters
    
    func getAccommodationDetailsModel() -> AccommodationDetailModel? {
        return self.accommodationDetails
    }
    
    func getAccommodationGallery() -> AccommodationGalleryModel? {
        return self.accommodationGallery
    }
    
    func getAccommodationProperties() -> AccommodationPropertiesModel? {
        return self.accommodationProperties
    }
    
    // MARK: fetch methods
    
    func fetchAccommodationDetails(for accommodationId: String, accommodationType: String) {
        networkController.getAccommodationDetails(accommodationId, accommodationType) { (details) in
            self.accommodationDetails = details
        }
    }
    
    func fetchAccommodationGallery(for accommodationId: String) {
         networkController.getAccommodationPictures(accommodationId) { (pictures) in
            self.accommodationGallery = pictures 
        }
    }

    func fetchAccommodationProperties(for accommodationId: String) {
        networkController.getAccommodationProperties(accommodationId) { (properties) in
            self.accommodationProperties = properties
        }
    }
}


