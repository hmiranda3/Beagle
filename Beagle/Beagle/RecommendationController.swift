//
//  RecommendationController.swift
//  Beagle
//
//  Created by Habib Miranda on 7/5/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import Foundation
import CoreData

class RecommendationContoller {
    
    static let sharedController = RecommendationContoller()
    
    let fetchedResultsController: NSFetchedResultsController
    
    init() {
        let request  = NSFetchRequest(entityName: "Recommendation")
        let categorySortDescriptor = NSSortDescriptor(key: "category", ascending: true)
        request.sortDescriptors = [categorySortDescriptor]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: "category", cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Unable to perform fetch request: \(error.localizedDescription)")
        }
        
    }
    
    // MARK: - Functionality
    
    func addRecommendation(title: String, category: String, recommender: String?, details: String?, alert: NSDate?) {
        let _ = Recommendation(title: title, category: category, recommender: recommender, details: details, alert: alert)
        saveToPersistentStorage()
    }
    
    func removeRecommendation(recommendation: Recommendation) {
        recommendation.managedObjectContext?.deleteObject(recommendation)
        saveToPersistentStorage()
    }
    
    func updateRecommendation(recommendation: Recommendation, title: String, category: String, recommender: String?, details: String?, alert: NSDate?) {
        recommendation.title = title
        recommendation.category = category
        recommendation.recommender = recommender
        recommendation.details = details
        recommendation.alert = alert
        saveToPersistentStorage()
    }
    
    func addSection(category: String) {
        let sectionTitle = category
    
    }
    
    // MARK: - Persistence 
    
    func saveToPersistentStorage() {
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("There was an error saving to Managed Object Context. Items not saved.")
        }
    }
    
}