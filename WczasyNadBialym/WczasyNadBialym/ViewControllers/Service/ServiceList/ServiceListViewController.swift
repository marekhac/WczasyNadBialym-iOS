//
//  ServiceListViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 26.04.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit
import SVProgressHUD

class ServiceListViewController: UITableViewController {

    let backgroundImageName = "background_gradient1"
    var serviceTypeName: String = "" // value will be assigned by parent view controller
    
    lazy var viewModel: ServiceListViewModel = {
        return ServiceListViewModel()
    }()
    
    // init view model
    
    func initViewModel () {
        
        // initialize callback closures
        // used [weak self] to avoid retain cycle
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                SVProgressHUD.dismiss()
            }
        }
    
        viewModel.initFetchServices(for: serviceTypeName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.addBlurSubview(image: backgroundImageName)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        
        initViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        cell.selectedBackgroundColor(UIColor(white: 1, alpha: 0.5))
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "serviceListCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ServiceListCell
        
        let serviceModel = viewModel.getServiceModel(at: indexPath)
        
        // Configure the cell...
        cell.name?.text = serviceModel.name
        cell.serviceId = serviceModel.id
        
        let imgMiniURL = serviceModel.imgMiniURL
        cell.imageMini.downloadImageAsync(imgMiniURL)
        
        // if there's no image, use default one from Assests/Services
        
        if (cell.imageMini.image == nil)
        {
            let serviceImage = UIImage(named: serviceTypeName + ".png")
            cell.imageMini.image = serviceImage
        }
            
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedCell = sender as? ServiceListCell {
            
            if segue.identifier == "showServiceDetails" {
                let controller = (segue.destination as! UINavigationController).topViewController as! ServiceDetailsViewController
                controller.selectedServiceId = String(selectedCell.serviceId!)
                controller.selectedServiceType = self.serviceTypeName
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
}
