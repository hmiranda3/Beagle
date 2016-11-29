//
//  DateHelper.swift
//  Beagle
//
//  Created by Habib Miranda on 7/4/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import Foundation

extension Date {
    
    func stringValue() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: self)
    }
    
}
