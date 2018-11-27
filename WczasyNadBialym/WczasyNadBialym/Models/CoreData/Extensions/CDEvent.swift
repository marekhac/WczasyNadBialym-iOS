//
//  CDEventHelper.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 07.11.2018.
//  Copyright © 2018 Marek Hać. All rights reserved.
//

import Foundation
import CoreData

extension CDEvent {
       
    convenience init(insert eventModel: EventModel, into context: NSManagedObjectContext) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "CDEvent", in:
            context)!
        self.init(entity: entityDescription, insertInto: context)
        
        id = Int16(eventModel.id)
        name = eventModel.name
        place = eventModel.place
        
        timestamp = Int32(eventModel.timestamp)
        
        // just added to context, NOT saved yet!
    }
    
    static func delete (index : Int, from context: NSManagedObjectContext) {
        
        let fetchRequest:NSFetchRequest<CDEvent> = CDEvent.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = \(index)")
        
        if let result = try? context.fetch(fetchRequest) {
            for object in result {
                context.delete(object)
            }
        }
        
        // just deleted to context, NOT saved yet!
    }
    
}

