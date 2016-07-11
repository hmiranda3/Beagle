//
//  Recommendation+CoreDataProperties.swift
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

extension Recommendation {

    @NSManaged var alert: NSDate?
    @NSManaged var details: String?
    @NSManaged var recommender: String?
    @NSManaged var title: String?
    @NSManaged var section: NSManagedObject?
    @NSManaged var isFavorite: Bool

}
