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
        
        SVProgressHUD.setMinimumDismissTimeInterval(2)
        
        self.navigationItem.title = "Imprezy"
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
       return viewModel.numberOfCells
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        cell.selectedBackgroundColor(UIColor(white: 1, alpha: 0.5))
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "eventsListCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EventListCell
        
        let eventModel = viewModel.getEventModel(at: indexPath)
        
        cell.name?.text = eventModel.name
        cell.eventId =  eventModel.id
        cell.date.text = eventModel.date.getDate() + ", godz. " + eventModel.date.getHourAndMinutes()
        
        NetworkManager.sharedInstance().getEventDetails(String(eventModel.id)) { (details) in
            if let details = details {
                cell.imageMini.downloadImageAsync(details.imgMedURL)
            }
        }
        return cell
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
