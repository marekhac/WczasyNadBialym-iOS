//
//  ServiceListViewModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 06.08.2018.
//  Copyright © 2018 Marek Hać. All rights reserved.
//

import UIKit

class ServiceListViewModel {
    
    var reloadTableViewClosure: (()->())?
    
    private var services = [ServiceModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var numberOfCells: Int { // this method is needed because "services"
        return services.count // is a private property, and not visibile in view controller
    }
    
    func getServiceModel(at indexPath: IndexPath) -> ServiceModel {
        return services[indexPath.row]
    }
    
    func initFetchServices(for serviceTypeName: String) {
        
        NetworkManager.sharedInstance().getServiceList (serviceTypeName) { (servicesDict, error) in
            print (servicesDict)
            
            self.services = servicesDict
        }
    }
}
