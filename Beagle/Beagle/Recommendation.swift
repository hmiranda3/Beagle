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
    static let recommenderKey = "recommender"
    static let detailsKey = "details"
    static let alertKey = "alert"
    static let isFavoriteKey = "isFavorite"
    
    convenience init(title: String, recommender: String? = "", details: String? = "", alert: NSDate? = nil, isFavorite: Bool = false, category: String, isDone: Bool, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        guard let entity = NSEntityDescription.entityForName("Recommendation", inManagedObjectContext: context) else {
            fatalError("Error initializing Recommendation.")
        }
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.title = title
        self.recommender = recommender
        self.details = details
        self.alert = alert
        self.isFavorite = isFavorite
        self.category = category
        self.isDone = isDone
        
    }
}
