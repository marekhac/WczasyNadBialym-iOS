//
//  CDEventImage.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 27.11.2018.
//  Copyright © 2018 Marek Hać. All rights reserved.
//

import Foundation
import CoreData

extension CDEventImage {
    
    convenience init(insert imageData: NSData, into context: NSManagedObjectContext) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "CDEventImage", in:
            context)!
        self.init(entity: entityDescription, insertInto: context)
        
        image = imageData
        
        // just added to context, NOT saved yet!
    }
}
