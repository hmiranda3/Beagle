//
//  Recommendation+CoreDataProperties.swift
//  Beagle
//
//  Created by Habib Miranda on 7/30/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Recommendation {

    @NSManaged var alert: Date?
    @NSManaged var category: String?
    @NSManaged var details: String?
    @NSManaged var isDone: NSNumber?
    @NSManaged var isFavorite: NSNumber?
    @NSManaged var recommender: String?
    @NSManaged var title: String?

}
