//
//  EventListTableViewModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 23/05/2019.
//  Copyright © 2019 Marek Hać. All rights reserved.
//

import UIKit

class EventsListViewModel: NSObject {
    
    private lazy var networkController = NetworkController(session: URLSession.shared)
    var reloadTableViewClosure: (()->())?
    
    var events = [EventModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var numberOfCells: Int { // this method is needed because "services"
        return events.count // is a private property, and not visibile in view controller
    }
    
    func fetchEvents() {
        networkController.getEventsList() { (eventsDict) in
            if let eventsDict = eventsDict {                
                self.events = eventsDict
            }
        }
    }
}

extension EventsListViewModel: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return events.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        cell.selectedBackgroundColor(UIColor(white: 1, alpha: 0.5))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "eventsListCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EventListCell
        
        let eventModel = events[indexPath.row]
        
        cell.name?.text = eventModel.name
        cell.eventId =  eventModel.id
        cell.date.text = eventModel.date.getDate() + ", godz. " + eventModel.date.getHourAndMinutes()
        
        networkController.getEventDetails(String(eventModel.id)) { (details) in
            if let details = details {
                cell.imageMini.downloadImageAsync(details.imgMedURL)
            }
        }
        return cell
    }
}
