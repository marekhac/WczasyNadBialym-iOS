//
//  CoreDataManager.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 07.11.2018.
//  Copyright © 2018 Marek Hać. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer:NSPersistentContainer
    
    var viewContext:NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    let backgroundContext:NSManagedObjectContext!
    
    convenience init () {
        self.init(modelName: "WczasyNadBialym")
        self.load()
    }
    
    init(modelName:String) {
        persistentContainer = NSPersistentContainer(name: modelName)
        
        backgroundContext = persistentContainer.newBackgroundContext()
    }
    
    func configureContexts() {
        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true
        
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            // self.autoSaveViewContext()
            // self.configureContexts()
            completion?()
        }
    }
    
    func allEvents() -> [CDEvent] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDEvent")
        let cdEvents = try! viewContext.fetch(fetchRequest) as! [CDEvent]
        
        return cdEvents
    }
}
