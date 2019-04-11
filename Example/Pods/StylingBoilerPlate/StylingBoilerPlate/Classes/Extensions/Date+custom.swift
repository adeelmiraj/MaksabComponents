//
//  Date+custom.swift
//  My Pass UAE
//
//  Created by Pantera Engineering on 25/01/2017.
//  Copyright © 2017 Incubasys IT Solutions. All rights reserved.
//

import Foundation
import UIKit


public extension Date{

    public static func dateFromString(dateString:String,format:String="yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        return date
    }
    
    public static func stringFromDate(date:Date,format:String="yyyy-MM-dd'T'HH:mm:ss.SSSZ")->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        return dateFormatter.string(from: date)
    }
    
    public func string(format:String="yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> String {
        return Date.stringFromDate(date: self, format: format)
    }
    
    public func offsetFrom(date:Date) -> String {
        let unitFlags:Set<Calendar.Component> = [.year,.month ,.day, .hour, .minute, .second]
        let difference = Calendar.current.dateComponents(unitFlags, from: self,to:date)

        let minutes = "\(difference.minute!)m" + " "
        let hours = "\(difference.hour!)h" + " " + minutes
        let days = "\(difference.day!)d" + " " + hours
        let month = "\(difference.month!)M" + " " + days
        
        if difference.month! > 0  { return month}
        if difference.day!   > 0 { return days }
        if difference.hour!  > 0 { return hours }
        if difference.minute! > 0 { return minutes }
        return ""
    }
    
    public func offsetBy(unit:Calendar.Component, fromDate:Date) -> Int{
        let unitFlags:Set<Calendar.Component> = [unit]
        let difference = Calendar.current.dateComponents(unitFlags, from: fromDate, to: self)

        var result:Int!
        switch unit {
        case .year:
            result = difference.year ?? 0
        case .month:
            result = difference.month ?? 0
        case .day:
            result = difference.day ?? 0
        case .hour:
            result = difference.hour ?? 0
        case .minute:
            result = difference.minute ?? 0
        case .second:
            result = difference.second ?? 0
        case .nanosecond:
            result = difference.second ?? 0
        default:
            result = 0
        }
        
        return result
    }
    
    static public func localToUTC(date: Date)-> String{
        let dateFormater = DateFormatter()
        dateFormater.calendar = Calendar.current
        dateFormater.timeZone = TimeZone(abbreviation: "UTC")
        let currentTimeString = dateFormater.string(from: date)
        return currentTimeString
    }
	
	static public var timeStamp: String {
		let date = Date().timeIntervalSince1970
		return "\(date)"
	}
}
