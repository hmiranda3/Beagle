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

//struct User {
//    
//    let firstName: String
//    let lastName: String
//    let canBeNotified: Bool
//    let didSelect: Bool
//    var timestamp: NSDate
//    var recordName: String
//    var recordIDData: NSData?
//
//}

class User: CloudKitManagedObject {
    
    var username: String?
    let firstName: String?
    let lastName: String?
    let canBeNotified: Bool?
    let didSelect: Bool?
    var timestamp: NSDate
    var recordName: String
    var recordIDData: NSData?
    
    static let typeKey = "User"
    
    
    //MARK: SearchableRecord Methods
    //Need this
//    func matchesSearchTerm(searchTerm: String) -> Bool {
//        return (self.username?.array as? [User])?.filter({$0.matchesSearchTerm(searchTerm)}).count > 0
//    }
    
    //MARK: CloudKitManagedObject methods
    @objc var recordType: String = "User"
    
    @objc var cloudKitRecord: CKRecord? { // Inherits from the extention
        let recordID = CKRecordID(recordName: recordName)
        let record = CKRecord(recordType: recordType, recordID: recordID)
        
//        record["timestamp"] = timestamp // These keys "whatever" are from the CLoudKit documentation
//        record["photoData"] = CKAsset(fileURL: temporaryPhotoUrl)
        return record
    }
    
    //Dont know what's going on here.
    init?(record: CKRecord, username: String, firstName: String) {
        guard let timestamp = record.creationDate else { fatalError() }
        
        self.username = username
        self.firstName = firstName
        self.recordIDData = NSKeyedArchiver.archivedDataWithRootObject(record.recordID)
        self.recordName = nameForManagedObject()
        self.timestamp = timestamp
    }
    
}
























