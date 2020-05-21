//
//  ServiceListViewModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 06.08.2018.
//  Copyright © 2018 Marek Hać. All rights reserved.
//

import UIKit

class ServiceListViewModel: NSObject {
    
    private lazy var networkController = NetworkController(session: URLSession.shared)
    var reloadTableViewClosure: (()->())?
    var categoryNameShort: String = ""
        
    private var services = [ServiceModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    func fetchServices(for serviceTypeName: String) {
        
        networkController.getServiceList(serviceTypeName) { (servicesDict) in
            
            if let servicesDict = servicesDict {
                self.services = servicesDict
            }
        }
    }
}

extension ServiceListViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        cell.selectedBackgroundColor(UIColor(white: 1, alpha: 0.5))
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "serviceListCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ServiceListCell
        
        let serviceModel = self.services[indexPath.row]
        
        // Configure the cell...
        cell.name?.text = serviceModel.name
        cell.serviceId = serviceModel.id
        
        let imgMiniURL = serviceModel.imgMiniURL
        
        cell.imageMini.image = UIImage(named: categoryNameShort + ".png") // default image
        cell.imageMini.downloadImageAsyncAndReturnImage(imgMiniURL) { (image) in
            
            // we use real service image in details view, to setup blured background
            
            cell.realServiceImage = image
        }
        
        return cell
    }
}
