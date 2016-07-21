//
//  User.swift
//  Beagle
//
//  Created by Habib Miranda on 7/19/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import Foundation
import CoreData
import CloudKit


class User: CloudKitManagedObject {
    
    let username: String?
    let firstName: String?
    let lastName: String?
    let canBeNotified: Bool?
    let didSelect: Bool?
    let timestamp: NSDate
    let recordName: String
    let recordIDData: NSData?
    
    static let typeKey = "User"
    
    
    //MARK: SearchableRecord Methods
    //Need this
//    func matchesSearchTerm(searchTerm: String) -> Bool {
//        return (self.username as? [User])?.filter({$0.matchesSearchTerm(searchTerm)}).count > 0
//    }
    
    //MARK: CloudKitManagedObject methods
    var recordType: String = "User"
    
    var cloudKitRecord: CKRecord? { // Inherits from the extention
        let recordID = CKRecordID(recordName: self.recordName)
        let record = CKRecord(recordType: recordType, recordID: recordID)
        
        record["username"] = username
        record["firsName"] = firstName
        record["lastName"] = lastName
        record["canBeNotified"] = canBeNotified
        record["didSelect"] = didSelect
        
        return record
    }
    
    //Dont know what's going on here.
    required init?(record: CKRecord, username: String, firstName: String, lastName: String, canBeNotified: Bool, didSelect: Bool) {
        guard let timestamp = record.creationDate else { fatalError() }
        
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.canBeNotified = canBeNotified
        self.didSelect = didSelect
        self.recordIDData = NSKeyedArchiver.archivedDataWithRootObject(record.recordID)
        self.recordName = record.recordID.recordName
        self.timestamp = timestamp
    }
    
}
























