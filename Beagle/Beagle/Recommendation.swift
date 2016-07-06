//
//  Recommendation.swift
//  Beagle
//
//  Created by Habib Miranda on 6/29/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import Foundation
import CoreData


class Recommendation: NSManagedObject {
    
    static let recommendationKey = "Recommendation"
    static let titleKey = "title"
    static let categoryKey  = "category"
    static let recommenderKey = "recommender"
    static let detailsKey = "details"
    static let alertKey = "alert"
    
    convenience init(title: String, category: String, recommender: String? = "", details: String? = "", alert: NSDate? = nil, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        let entity = NSEntityDescription.entityForName("Recommendation", inManagedObjectContext: context)!
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.title = title
        self.category = category
        self.recommender = recommender
        self.details = details
        self.alert = alert
    }
}
