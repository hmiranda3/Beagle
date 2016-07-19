//
//  RecommendationController.swift
//  Beagle
//
//  Created by Habib Miranda on 7/5/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import Foundation
import CoreData
import NotificationCenter

class RecommendationContoller {
    
    static let sharedController = RecommendationContoller()
    
    let fetchedResultsController: NSFetchedResultsController
    
    var recommendation: Recommendation?
    
    init() {
        let request  = NSFetchRequest(entityName: "Recommendation")
        let categorySortDescriptor = NSSortDescriptor(key: "category", ascending: true)
        request.sortDescriptors = [categorySortDescriptor]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: "category", cacheName: nil)
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
    
    func addRecommendation(title: String, category: String, recommender: String?, details: NSAttributedString?, alert: NSDate?, isFavorite: Bool, isDone: Bool) {
        let recommendation = Recommendation(title: title, recommender: recommender, details: details, alert: alert, isFavorite: isFavorite, category: category, isDone: isDone)
        if (recommendation.category == "") {
            
            print("no category")
            return recommendation.category = "Other"
        }

        saveToPersistentStorage()
    }
    
    func removeRecommendation(recommendation: Recommendation) {
        recommendation.managedObjectContext?.deleteObject(recommendation)
        saveToPersistentStorage()
    }
    
    func updateRecommendation(recommendation: Recommendation, title: String, category: String, recommender: String?, details: NSAttributedString?, alert: NSDate?) {
        
        recommendation.title = title
        recommendation.recommender = recommender
        recommendation.details = details
        recommendation.alert = alert
        recommendation.category = category
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
    
    func isDoneValueToggle(recommendation: Recommendation) {
        if recommendation.isDone == false {
            recommendation.isDone = true
            print(recommendation.isDone)
        } else {
            recommendation.isDone = false
            print(recommendation.isDone)
        }
        saveToPersistentStorage()
    }
    
    
    // MARK: - Persistence
    
    func saveToPersistentStorage() {
        do {
            try Stack.sharedStack.managedObjectContext.save()
            print("Success Saving!")
        } catch let error as NSError {
            print("There was an error saving to Managed Object Context. Items not saved: \(error.localizedDescription)")
        }
    }
}