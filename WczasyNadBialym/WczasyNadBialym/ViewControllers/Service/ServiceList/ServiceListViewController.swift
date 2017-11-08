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

    var services = [ServiceModel]()
    var serviceTypeName: String = ""
    
    func reloadTableViewAndDismissHUD () {
        
        let queue = OperationQueue()
        
        let reloadTableView = BlockOperation(block: {
            
            OperationQueue.main.addOperation({
                self.tableView.reloadData()
            })
        })
        
        queue.addOperation(reloadTableView)
        
        let dismissProgressHUD = BlockOperation(block: {
            
            OperationQueue.main.addOperation({
                SVProgressHUD.dismiss()
            })
        })
        
        dismissProgressHUD.addDependency(reloadTableView)
        queue.addOperation(dismissProgressHUD)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.addBlurSubview(image: "background_gradient1")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        
        NetworkManager.sharedInstance().getServiceList (serviceTypeName) { (servicesDict, error) in
            print (servicesDict)
            
            self.services = servicesDict
      
            self.reloadTableViewAndDismissHUD()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.services.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        cell.selectedBackgroundColor(UIColor(white: 1, alpha: 0.5))
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "serviceListCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ServiceListCell
        
        // Configure the cell...
        
        cell.name?.text = (self.services[indexPath.row] as ServiceModel).name
        cell.serviceId = (self.services[indexPath.row] as ServiceModel).id
        
        let imgMiniURL = (self.services[indexPath.row] as ServiceModel).imgMiniURL
        cell.imageMini.downloadImageAsync(imgMiniURL)
        
        // if there's no image, use default one from Assests/Services
        
        if (cell.imageMini.image == nil)
        {
            let serviceImage = UIImage(named: serviceTypeName + ".jpg")
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
