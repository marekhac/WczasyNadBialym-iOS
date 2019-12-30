//
//  EventListViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 09.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit
import SVProgressHUD

class EventListViewController: UITableViewController {
 
    var events = [String:[EventDetailModel]]()
    
    lazy var viewModel: EventsListViewModel = {
        return EventsListViewModel()
    }()
    
    // init view model
    
    func initViewModel () {
        
        // initialize callback closures
        // used [weak self] to avoid retain cycle
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            
            SVProgressHUD.dismiss()
            
            if (self?.viewModel.numberOfCells == 0) {
                SVProgressHUD.showInfo(withStatus: "Brak imprez \u{1F494}")
                return
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.fetchEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        SVProgressHUD.show()
        
        // blur tableview background
        
        self.tableView.addBlurSubview(image: "background_gradient2")
        
        initViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationItem.title = "Imprezy"
        
        self.tableView.dataSource = viewModel
        self.tableView.delegate = viewModel
        
        SVProgressHUD.setMinimumDismissTimeInterval(2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedCell = sender as? EventListCell {
            
            if segue.identifier == "showEventPreview" {
                let controller = (segue.destination as! UINavigationController).topViewController as! EventPreviewViewController
                controller.selectedEventId = String(selectedCell.eventId!)
                controller.backgroundImage = selectedCell.imageMini.image;
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}
