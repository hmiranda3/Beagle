//
//  Section+CoreDataProperties.swift
//  Beagle
//
//  Created by Habib Miranda on 7/6/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Section {

    @NSManaged var group: String?
    @NSManaged var recommendations: NSOrderedSet?

}
