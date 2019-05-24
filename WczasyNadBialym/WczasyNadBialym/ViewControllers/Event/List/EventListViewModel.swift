//
//  EventListTableViewModel.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 23/05/2019.
//  Copyright © 2019 Marek Hać. All rights reserved.
//

import Foundation

class EventsListViewModel {
    
    var reloadTableViewClosure: (()->())?
    
    private var events = [EventModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var numberOfCells: Int { // this method is needed because "services"
        return events.count // is a private property, and not visibile in view controller
    }
    
    func getEventModel(at indexPath: IndexPath) -> EventModel {
        return events[indexPath.row]
    }
    
    func fetchEvents() {
        
        NetworkManager.sharedInstance().getEventsList() { (eventsDict) in
            if let eventsDict = eventsDict {                
                self.events = eventsDict
            }
        }
    }
}
