//
//  Date+Formatter.swift
//  Boonco
//
//  Created by Peter Huang on 2020-05-08.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

public extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")!
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
    
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }()
}

public extension Date {
    var plainDate: Date? {
        get {
            let calender = Calendar.current
            let dateComponents = calender.dateComponents([.year, .month, .day], from: self)
            return calender.date(from: dateComponents)
        }
    }
    
    /// Returns the number of years from the given date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    
    /// Returns the number of months from the given date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    
    /// Returns the number of weeks from the given date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    
    /// Returns the number of days from the given date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    /// Returns the number of hours from the given date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    /// Returns the number of minutes from the given date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    /// Returns the number of seconds from the given date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    /// Returns the  time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date) > 0 { return "\(years(from: date))y" }
        if months(from: date) > 0 { return "\(months(from: date))M" }
        if weeks(from: date) > 0 { return "\(weeks(from: date))w" }
        if days(from: date) > 0 { return "\(days(from: date))d" }
        if hours(from: date) > 0 { return "\(hours(from: date))h" }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    
    func diffenceInTime(lastUpdateTime: Date?) -> String {
        guard let date = lastUpdateTime else {
            return String.notApplicable
        }
        if seconds(from: date) < 10 { return NSLocalizedString("few_seconds_ago", comment: "") }
        if seconds(from: date) < 60 {
            return String(format: NSLocalizedString("seconds_ago", comment: ""), seconds(from: date))
        }
        if minutes(from: date) == 1 { return NSLocalizedString("one_minute_ago", comment: "") }
        if minutes(from: date) < 60 {
            return String(format: NSLocalizedString("minutes_ago", comment: ""), minutes(from: date))
        }
        if hours(from: date) == 1 { return NSLocalizedString("one_hour_ago", comment: "") }
        if hours(from: date) < 24 {
            return String(format: NSLocalizedString("hours_ago", comment: ""), hours(from: date))
        }
        if days(from: date) == 1 { return NSLocalizedString("one_day_ago", comment: "") }
        if days(from: date) < 30 {
            return String(format: NSLocalizedString("days_ago", comment: ""), days(from: date))
        }
        if months(from: date) == 1 { return NSLocalizedString("one_month_ago", comment: "") }
        if months(from: date) > 1 {
            return String(format: NSLocalizedString("months_ago", comment: ""), months(from: date))
        }
        return ""
    }
}
