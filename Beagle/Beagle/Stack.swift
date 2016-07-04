//
//  Stack.swift
//  Beagle
//
//  Created by Habib Miranda on 6/28/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import Foundation
import CoreData

class Stack {
    
    static let sharedStack = Stack()
    
    //Lazy will not load unless it's called. NSManagedObjectContex manages models.
    lazy var managedObjectContext: NSManagedObjectContext = Stack.setUpMainContext()
    
    //we need a bank teller and a coordinator
    //Make a managed store context, a persistent store coordinator, and a plac to put it all in.
    
    static func setUpMainContext() -> NSManagedObjectContext {
        let bundle = NSBundle.mainBundle() //Helps us acces where things are saved on the device and merge models into a bundle.
        guard let model = NSManagedObjectModel.mergedModelFromBundles([bundle])
            else { fatalError("model not found") }
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model) // takes model info an stores to persistent store.
        try! persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, //telling the coordinator to store in SQL(in this case)
            URL: storeURL(), options: nil)
        let context = NSManagedObjectContext(
            concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator //Every managed object context has a store coordinator. Here we set it equal to the one we made.
        return context
    }
    
    //What vault are we putting it in.
    static func storeURL () -> NSURL? { //Creating a URL that be accessed. Equivalent to the vault number.
        let documentsDirectory: NSURL? = try? NSFileManager.defaultManager().URLForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: true) //asking what vault we can put it in.
        
        return documentsDirectory?.URLByAppendingPathComponent("db.sqlite") //This is what will be put in the vault. Think of "db.sqlite" as a .jpg.
    }
    
}

//managed Context is the first goblin, coordinator is the second goblin.
//Managed Object is the model