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
        let categorySortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [categorySortDescriptor]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: "Section", cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("There was an error performing recommendations fetch request: \(error.localizedDescription)")
        }
        
    }
    
    func getFavoriteRecommendations() -> [Recommendation] {
        
        let request = NSFetchRequest(entityName: "Recommendation")
        let predicate = NSPredicate(format: "isFavorite == 1")
        request.predicate = predicate
        
        var recommendations: [Recommendation] = []
        do {
            recommendations = try Stack.sharedStack.managedObjectContext.executeFetchRequest(request) as? [Recommendation] ?? []

        } catch let error as NSError {
            print("Error fetching favorited Recommendations: \(error.localizedDescription) --> \(#function)")
        }
        
        return recommendations
    }
    // MARK: - Functionality
    
    func addRecommendation(title: String, category: Section, recommender: String?, details: String?, alert: NSDate?) {
        let rec = Recommendation(title: title, recommender: recommender, details: details, alert: alert)
        rec.section = category
        saveToPersistentStorage()
    }
    
    func removeRecommendation(recommendation: Recommendation) {
        recommendation.managedObjectContext?.deleteObject(recommendation)
        saveToPersistentStorage()
    }
    
    func updateRecommendation(recommendation: Recommendation, title: String, category: Section, recommender: String?, details: String?, alert: NSDate?) {
      
        recommendation.title = title
        recommendation.recommender = recommender
        recommendation.details = details
        recommendation.alert = alert
        recommendation.section = category
        saveToPersistentStorage()
    }
    
    func isFavoriteValueToggle(recommendation: Recommendation) {
        if recommendation.isFavorite == false {
            recommendation.isFavorite = true
            print(recommendation.isFavorite)
        } else {
            recommendation.isFavorite = false
            print(recommendation.isFavorite)
        }
        saveToPersistentStorage()
    }
    
  
    
    // MARK: - Persistence 
    
    func saveToPersistentStorage() {
        do {
            try Stack.sharedStack.managedObjectContext.save()
            print("Success Saving!")
        } catch {
            print("There was an error saving to Managed Object Context. Items not saved.")
        }
    }
}