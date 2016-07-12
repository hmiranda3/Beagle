//
//  SectionController.swift
//  Beagle
//
//  Created by Habib Miranda on 7/6/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import Foundation
import CoreData

class SectionController {
    
    static let  sharedController = SectionController()
    
    let fetchedResultsController: NSFetchedResultsController

    
    // Fetches all sections from CoreData
    var sectionsArray: [Section] {
        let sortDescriptor = NSSortDescriptor(key: "group", ascending: true)
        let request = NSFetchRequest(entityName: Section.typeKey)
        request.sortDescriptors = [sortDescriptor]
        let results = (try? Stack.sharedStack.managedObjectContext.executeFetchRequest(request)) as? [Section] ?? []
       
        return results
    }
    
    // Sets up the sections when the sharedController is called.
    init() {

        let request  = NSFetchRequest(entityName: "Section")
        let categorySortDescriptor = NSSortDescriptor(key: "group", ascending: true)
        request.sortDescriptors = [categorySortDescriptor]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("There was an error performing recommendations fetch request: \(error.localizedDescription)")
        }
        if sectionsArray.count == 0 {
            setupSections()
        }
    }
    
    // Saves objects to CoreData
    func saveSection() {
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("There was an error saving Section to Managed Object Context. Items not saved.")
        }
    }
    
    // Sets up the origianl sections and saves them to CoreData
    func setupSections() {
        
        let _ = Section(group: "Food")
        let _ = Section(group: "Books")
        let _ = Section(group: "Travel")
        let _ = Section(group: "Movies & Shows")
        let _ = Section(group: "Entertainment")
        let _ = Section(group: "Arts & Crafts")
        let _ = Section(group: "Music")
        let _ = Section(group: "Games & Apps")
        let _ = Section(group: "Lifestyle & Health")
        let _ = Section(group: "Other")
        saveSection()

    }
}

