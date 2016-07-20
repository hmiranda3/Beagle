//
//  CloudKitManagedObject.swift
//  Beagle
//
//  Created by Habib Miranda on 7/19/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import Foundation
import CoreData
import CloudKit

@objc protocol CloudKitManagedObject {
    
    var timestamp: NSDate { get set } //this to sort the timeline
    var recordIDData: NSData? { get set } //in order to save
    var recordName: String { get set } //
    var recordType: String { get }
    
    var cloudKitRecord: CKRecord? { get } // CloudKit dictionary. Gets data and makes it a cloud kit record.
    
    init?(record: CKRecord, context: NSManagedObjectContext) //Takes in a CKRecord and turns it into a costum model object.
    
}

extension CloudKitManagedObject {
    
    var isSynced: Bool {
        return recordIDData != nil
    }
    
    //Serializes NSData and turns it into a CKRecord. We can find that record through the ID.
    var cloudKitRecordID: CKRecordID? {
        guard let recordIDData = recordIDData,
            recordID = NSKeyedUnarchiver.unarchiveObjectWithData(recordIDData) as? CKRecordID else {
                return nil
        }
        return recordID
    }
    
    //We check to see if there is a recordID and return a CKRecord if there is.
    var cloudKitReference: CKReference? {
        guard let recordID = cloudKitRecordID else {
            return nil
        }
        return CKReference(recordID: recordID, action: .None)
    }
    
    //Takes in a cloud kit ditionary(CKRecord) and serializes it from a CKRecord to NSData, which can be stored into core data.
    func update(record: CKRecord) {
        self.recordIDData = NSKeyedArchiver.archivedDataWithRootObject(record.recordID)
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("Unable to save Managed Object Context in \(#function) \nError: \(error)")
        }
    }
    
    //Generates a unique identifier and returns a string.
    func nameForManagedObject() -> String {
        return NSUUID().UUIDString
    }
    
}