//
//  DateUtils.swift
//  Gank
//
//  Created by 魏星 on 16/7/17.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
public class DateUtils{
    
    static let  DATE_FORMATTER = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    public static func stringToNSDate(dateString: String,formatter: String = DATE_FORMATTER) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.dateFromString( dateString )!
    }
    
    public static func nsDateToString(date: NSDate,formatter: String = "yyyy-MM-dd HH:mm:ss" ) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.stringFromDate(date)
    }
    
    public static func areDatesSameDay(dateOne:NSDate,dateTwo:NSDate) -> Bool {
        let calender = NSCalendar.currentCalendar()
        let flags: NSCalendarUnit = [.Day, .Month, .Year]
        let compOne: NSDateComponents = calender.components(flags, fromDate: dateOne)
        let compTwo: NSDateComponents = calender.components(flags, fromDate: dateTwo);
        return (compOne.day == compTwo.day && compOne.month == compTwo.month && compOne.year == compTwo.year);
    }
    
    public static func getYMDTupleArray() ->[(String,String,String)]{
        
        var date = NSDate()
        
        var ymdTuples:[(String,String,String)] = []
        for _ in 0...4{
            date = getDateYesterday(date)
            ymdTuples += [getYMDTypleFromDate(date)]
            
        }
        return ymdTuples
    }
    
    private static func getDateYesterday(date: NSDate) -> NSDate{
        let calender = NSCalendar.currentCalendar()
        return calender.dateByAddingUnit(.Day, value: -1, toDate: date, options: .MatchStrictly)!
    }
    
    private static func getYMDTypleFromDate(date: NSDate) -> (String,String,String){
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let datesStr = formatter.stringFromDate(date)
        let dates = datesStr.componentsSeparatedByString("/")
        return (dates[0],dates[1],dates[2])
    }

    
}
