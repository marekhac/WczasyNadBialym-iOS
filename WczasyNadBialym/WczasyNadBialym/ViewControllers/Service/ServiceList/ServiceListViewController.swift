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
        self.navigationItem.title = self.categoryNameLong
        
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
        
        cell.imageMini.image = UIImage(named: categoryNameShort + ".png") // default image
        cell.imageMini.downloadImageAsyncAndReturnImage(imgMiniURL) { (image, error) in
            
            // we use real service image in details view, to setup blured background
            
            cell.realServiceImage = image
        }
        
        return cell
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
