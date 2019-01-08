//
//  EventListTableViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 09.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit
import SVProgressHUD

class EventListTableViewController: UITableViewController {
 
    var events = [String:[EventDetailModel]]()
    var sections = [EventsInYearModel]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.sections.removeAll()
        
        SVProgressHUD.show()
        
        // blur tableview background
        
        self.tableView.addBlurSubview(image: "background_gradient2")
        
        NetworkManager.sharedInstance().getEventSections () { (eventSections) in
            
            if let eventSections = eventSections {
                
                // skip empty sections. f.e. years where there aren't any events
                
                for section in eventSections {
                    SVProgressHUD.dismiss()
                    
                    if (section.events.count != 0) {
                        self.sections.append(section)
                    }
                }
                
                if (self.sections.count == 0) {
                    SVProgressHUD.showInfo(withStatus: "Brak imprez \u{1F494}")
                }
                else {
                    OperationQueue.main.addOperation({
                        self.tableView.reloadData()
                    })
                }
            }
        }
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
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return sections[section].events.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        cell.selectedBackgroundColor(UIColor(white: 1, alpha: 0.5))
    }
        
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Rok " +  String(self.sections[section].year)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        
        view.tintColor = UIColor(white: 1, alpha: 0.9)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.orange // header section label color
       // header.textLabel?.textAlignment = NSTextAlignment.center // header section label alignment
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "eventsListCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EventListCell
        
        let event : EventsInYearModel.EventModel = sections[indexPath.section].events[indexPath.row]
        
        cell.name?.text = event.name
        cell.eventId =  event.id
        cell.date.text = event.date.getDate() + ", godz. " + event.date.getHourAndMinutes()
        
        NetworkManager.sharedInstance().getEventDetails(String(event.id)) { (details) in
            if let details = details {
                cell.imageMini.downloadImageAsync(details.imgMedURL)
            }
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedCell = sender as? EventListCell {
            
            if segue.identifier == "showEventDetails" {
                let controller = (segue.destination as! UINavigationController).topViewController as! EventDetailsViewController
                controller.selectedEventId = String(selectedCell.eventId!)
                     controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}
