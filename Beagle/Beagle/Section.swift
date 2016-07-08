//
//  Section.swift
//  Beagle
//
//  Created by Habib Miranda on 7/6/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import Foundation
import CoreData

class Section: NSManagedObject {
    
    static let typeKey = "Section"

    convenience init(group: String, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        guard let entity = NSEntityDescription.entityForName(Section.typeKey, inManagedObjectContext: context) else {
            fatalError("Error: Core Data failed to create entity from entity description.")
        }
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.group = group
    }
    
}
