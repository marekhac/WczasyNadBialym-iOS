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

    let backgroundImageName = "background_blue"
    
    // these values will be assigned by parent view controller in prepare for segue
    
    var categoryNameShort: String = ""
    var categoryNameLong: String = ""
    
    lazy var viewModel: ServiceListViewModel = {
        return ServiceListViewModel()
    }()
    
    // init view model
    
    func initViewModel () {
        
        // initialize callback closures
        // used [weak self] to avoid retain cycle
        
        viewModel.categoryNameShort = self.categoryNameShort
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                SVProgressHUD.dismiss()
            }
        }
    
        viewModel.fetchServices(for: categoryNameShort)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.addBlurSubview(image: backgroundImageName)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = viewModel
        self.tableView.delegate = viewModel
            
        self.navigationItem.title = self.categoryNameLong
        
        SVProgressHUD.show()
        
        initViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedCell = sender as? ServiceListCell {
            
            if segue.identifier == "showServiceDetails" {
                let controller = (segue.destination as! UINavigationController).topViewController as! ServiceDetailsViewController
                controller.selectedServiceId = String(selectedCell.serviceId!)
                controller.selectedServiceType = self.categoryNameShort
                controller.backgroundImage = selectedCell.realServiceImage;
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}
