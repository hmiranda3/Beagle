//
//  Recommendation+CoreDataProperties.swift
//  Beagle
//
//  Created by Habib Miranda on 6/29/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Recommendation {

    @NSManaged var title: String
    @NSManaged var category: String
    @NSManaged var recommender: String?
    @NSManaged var alert: NSDate?
    @NSManaged var details: String?

}
