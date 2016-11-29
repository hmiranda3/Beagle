//
//  FavoriteController.swift
//  Beagle
//
//  Created by Habib Miranda on 7/13/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import Foundation
import CoreData

class FavoriteController {
    
    static let sharedController = FavoriteController()

    let favoriteFetchedResultsController: NSFetchedResultsController<Recommendation>

    init () {
        let favoriteRequest = NSFetchRequest<Recommendation>(entityName: "Recommendation")
        let favoriteCategorySortDescriptor = NSSortDescriptor(key: "category", ascending: true)
        favoriteRequest.sortDescriptors = [favoriteCategorySortDescriptor]
        let predicate = NSPredicate(format: "isFavorite == 1")
        favoriteRequest.predicate = predicate
        self.favoriteFetchedResultsController = NSFetchedResultsController(fetchRequest: favoriteRequest, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: "category", cacheName: nil)
        do {
            try favoriteFetchedResultsController.performFetch()
        } catch let error as NSError {
            print("There was an error performing recommendations fetch request: \(error.localizedDescription)")
        }
    }
}
