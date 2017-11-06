//
//  EventListTableViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 09.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit

class EventListTableViewController: UITableViewController {

    var events = [String:[EventDetailModel]]()
    var sections = [EventsInYearModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Imprezy"
        
        NetworkManager.sharedInstance().getEventSections () { (eventSections, error) in
            print (eventSections)
            self.sections = eventSections
            
            OperationQueue.main.addOperation({
                self.tableView.reloadData()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return sections[section].events.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "test" //return sections[section].heading
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "eventsListCell"
    
        print ((sections[indexPath.section].events[indexPath.row] as EventsInYearModel.EventModel).name)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EventListCell
        cell.name?.text = (sections[indexPath.section].events[indexPath.row] as EventsInYearModel.EventModel).name
        cell.eventId =  (sections[indexPath.section].events[indexPath.row] as EventsInYearModel.EventModel).id
        
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
