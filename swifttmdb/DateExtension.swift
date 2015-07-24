//
//  DateExtention.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 7/24/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import UIKit

// MARK: - Various date utils
public extension NSDate {
    
    
    // MARK: Components
    private class func componentFlags() -> NSCalendarUnit { return NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitWeekOfYear | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond  | NSCalendarUnit.CalendarUnitWeekday | NSCalendarUnit.CalendarUnitWeekdayOrdinal | NSCalendarUnit.CalendarUnitWeekOfYear }
    
    private class func components(#fromDate: NSDate) -> NSDateComponents! {
        return NSCalendar.currentCalendar().components(NSDate.componentFlags(), fromDate: fromDate)
    }
    
    private func components() -> NSDateComponents  {
        return NSDate.components(fromDate: self)!
    }
    
    /**
    Return the first day of the month
    
    :returns: the first day of the montn
    */
    func dayAtTheStartOfMonth() -> NSDate
    {
        
        //Builds current calendar
        let calendar = NSCalendar.currentCalendar()
        //Create the date components
        let components = self.components()
        components.day = 1
        //Builds the first day of the month
        let firstDayOfMonthDate :NSDate = calendar.dateFromComponents(components)!
        
        return firstDayOfMonthDate
        
    }
    
    /**
    Returns the last day of the montn
    
    :returns: the last day of the month
    */
    func dayAtTheEndOfMonth() -> NSDate {
        
        //Builds current calendar
        let calendar = NSCalendar.currentCalendar()
        //Create the date components
        let components = self.components()
        //Set the last day of this month
        components.month += 1
        components.day = 0
        
        //Builds the first day of the month
        let lastDayOfMonth :NSDate = calendar.dateFromComponents(components)!
        
        return lastDayOfMonth
        
    }
    
    /**
    Returns the string representation of the date as yyyy-MM-dd

    :returns: yyyy-MM-dd
    */
    func simpleDateFormatString() -> String
    {
        
        let dateFormater = NSDateFormatter()
        
        dateFormater.dateFormat = "yyyy-MM-dd"
        
        return dateFormater.stringFromDate(self)
        
    }

    
    
   
}
