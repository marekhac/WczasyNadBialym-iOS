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
    var eventsToShow = [CDEvent]()
    var imageMini = UIImageView()
    
    @IBAction func startSynchronization(_ sender: Any) {
        
        print("start synchronization")
    
        let coreDataManager = CoreDataManager()
        let viewContext = coreDataManager.viewContext
        
        // create dict with ids and timestamps
        
        var localIds = [String : Any]()
        let events = coreDataManager.allEvents()
        
        for event in events {
            localIds[String(event.id)] = event.timestamp
        }
        
        // send local ids and timestamps to server to be processed
        
        NetworkManager.sharedInstance().postEventDeltas (localIds) { (results, error) in
            
            // in results we got array of events to update, and array of indexes to delete
            
            // delete
            
            for index in results.delete {
                _ = CDEvent.delete(index: index, from: viewContext)
            }
            
            // update
            
            for event in results.update {
                
                let eventEntity = CDEvent(insert: event, into: viewContext)
                
                // download images
                
                self.imageMini.downloadImageAsyncAndReturnImage(event.imgMedURL) { [weak self] (resultImage, error) in
                    
                    let imageData = NSData(data: UIImageJPEGRepresentation(resultImage, 1.0)!)
                    
                    let eventImageEntity = CDEventImage(insert: imageData, into: viewContext)
                    
                    eventEntity.addToImages(eventImageEntity) // assign image entity to event entity
                    
                    try! coreDataManager.viewContext.save()
                    
                    self?.tableView.reloadData()
                }
            }
            
            // save changes to persitent store
            
            try! coreDataManager.viewContext.save()
            
            // get all current events from coredata
            
            self.eventsToShow = coreDataManager.allEvents()
            
            // update the tableview
            
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        SVProgressHUD.show()
        
        // blur tableview background
        
        self.tableView.addBlurSubview(image: "background_gradient2")

        let synchronizer = Synchronizer()
        
        let coreDataManager = synchronizer.coreDataManager
        eventsToShow = coreDataManager.allEvents()
                
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
        
        if (self.eventsToShow.count == 0) {
            SVProgressHUD.showInfo(withStatus: "Brak imprez \u{1F494}")
        }
        else {
            SVProgressHUD.dismiss()
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return self.eventsToShow.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        cell.selectedBackgroundColor(UIColor(white: 1, alpha: 0.5))
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

        let event : CDEvent = eventsToShow[indexPath.row]
        
        cell.name?.text = event.name
        cell.eventId = Int(event.id)
        cell.date.text = "test" //event.date.getHourAndMinutes()
       
        for data in event.images! {
            
            var eventImage : CDEventImage
            eventImage = data as! CDEventImage
            
            cell.imageMini.image = UIImage(data: eventImage.image! as Data)
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
