//
//  AccommodationListViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 13.09.2016.
//  Copyright © 2016 Marek Hać. All rights reserved.
//

import UIKit
import SVProgressHUD

class AccommodationListViewController: UITableViewController {

    var accommodation = [AccommodationModel]()
    var accommodationTypeName: String = ""
    
    func reloadCollectionViewAndDismissHUD () {
        
        let queue = OperationQueue()
        
        let reloadCollectionView = BlockOperation(block: {
            
            OperationQueue.main.addOperation({
                self.tableView.reloadData()
            })
        })
        
        queue.addOperation(reloadCollectionView)
        
        let updateCollectionViewHeightContraint = BlockOperation(block: {
            
            OperationQueue.main.addOperation({
                SVProgressHUD.dismiss()
            })
        })
        
        updateCollectionViewHeightContraint.addDependency(reloadCollectionView)
        queue.addOperation(updateCollectionViewHeightContraint)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        self.tableView.addBlurSubview(image: "background_blue")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        NetworkManager.sharedInstance().getAccommodationListBasic(accommodationTypeName) { (accommodationDict, error) in
              print (accommodationDict)
            
            self.accommodation = accommodationDict
            
            self.reloadCollectionViewAndDismissHUD()
        }
        
        // Do any additional setup after loading the view.
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
        return self.accommodation.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "accommodationListCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AccommodationListCell
        
        // Configure the cell...
        
        cell.name?.text = (self.accommodation[indexPath.row] as AccommodationModel).name
        cell.accommodationId = (self.accommodation[indexPath.row] as AccommodationModel).id
        cell.price?.text = (self.accommodation[indexPath.row] as AccommodationModel).price
        let imgMiniURL = (self.accommodation[indexPath.row] as AccommodationModel).imgMiniURL
        
        cell.imageMini.downloadImageAsync(imgMiniURL, defaultImage: "accommodation_default_med.jpg")
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        cell.selectedBackgroundColor(UIColor(white: 1, alpha: 0.5))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedCell = sender as? AccommodationListCell {
            
            if segue.identifier == "showDetails" {
                let controller = (segue.destination as! UINavigationController).topViewController as! AccommodationDetailsViewController
                controller.selectedAccommodationId = String(selectedCell.accommodationId!)
                controller.selectedAccommodationType = self.accommodationTypeName
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}
