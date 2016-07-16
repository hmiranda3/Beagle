//
//  DateHelper.swift
//  Beagle
//
//  Created by Habib Miranda on 7/4/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import Foundation

extension NSDate {
    
    func stringValue() -> String {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        dateFormatter.dateStyle = .FullStyle
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(self)
    }
    
}
