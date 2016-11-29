//
//  SearchableRecord.swift
//  Beagle
//
//  Created by Habib Miranda on 7/21/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import Foundation

@objc protocol SearchableRecord: class {
    
    func matchesSearchTerm(_ searchTerm: String) -> Bool
}
