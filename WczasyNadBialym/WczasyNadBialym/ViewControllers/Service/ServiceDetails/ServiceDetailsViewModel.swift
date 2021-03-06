//
//  ServiceDetailsViewModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 08.08.2018.
//  Copyright © 2018 Marek Hać. All rights reserved.
//

import Foundation

class ServiceDetailsViewModel {
    
    private lazy var networkController = NetworkController(session: URLSession.shared)
    var updateViewClosure: (()->())?
    
    private var serviceDetails: ServiceDetailModel? {
        didSet {
            self.updateViewClosure?()
        }
    }
    
    func getServiceDetailsModel() -> ServiceDetailModel? {
        return self.serviceDetails
    }
    
    func fetchServiceDetails(for serviceId: String) {
        networkController.getServiceDetails(serviceId) { (service) in
            
            if let service = service {
                self.serviceDetails = service 
            }
        }
    }
}
