//
//  Utilities.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-30.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

struct Utilities {
    
    static func getDistance(fromMeters meters: UInt?) -> String {
        guard let meters = meters else {
            return "? m away"
        }
        if meters > 1000 {
            return "\(Int(meters/1000))km away"
        }
        else if meters > 100 {
            return "\(meters)m away"
        }
        else {
            return "Less than 100m away"
        }
    }
    
    static func getTimeframe(fromTimeframe timeframe: TimeInterval?, isDuration: Bool = false) -> String {
        guard let timeframe = timeframe else {
            return "Recently posted"
        }
        let timeframeInt = Int(timeframe)
        var labelText: String = ""
        
        //Below are total time measurements
        let seconds: Int = timeframeInt
        let minutes: Int = timeframeInt / 60
        let hours: Int = timeframeInt / 3600
        let days: Int = timeframeInt / 86400
        let weeks: Int = timeframeInt / 604800
        let months: Int = timeframeInt / 2678400
        
        if months > 1 {
            labelText = "\(Int(months)) months"
        } else if months == 1 {
            labelText = "\(Int(months)) month"
        } else if weeks > 1 {
            labelText = "\(Int(weeks)) weeks"
        } else if weeks == 1 {
            labelText = "\(Int(weeks)) week"
        } else if days > 1 {
            labelText = "\(Int(days)) days"
        } else if days == 1 {
            labelText = "\(Int(days)) day"
        } else if hours > 1 {
            labelText = "\(Int(hours)) hours"
        } else if hours == 1 {
            labelText = "\(Int(hours)) hour"
        } else if minutes > 1 {
            labelText = "\(Int(minutes)) minutes"
        } else if minutes == 1 {
            labelText = "\(Int(minutes)) minute"
        } else if seconds > 10 {
            labelText = "\(Int(seconds)) seconds"
        } else {
            labelText = "A few seconds"
        }
        
        if isDuration {
            labelText = "Available for \(labelText)"
        } else {
            labelText.append(" ago")
        }
        
        return labelText
    }
    
    static func convertTimeframeToRentalPeriod(withTimeframe timeframe: TimeInterval) -> RentalPeriod {
        switch(timeframe) {
        case 3600:
            return .hour
        case 86400:
            return .day
        case 604800:
            return .week
        default:
            return .other
        }
    }
    
    static func formatNumber(withCommas number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value: number))
        return formattedNumber ?? "n/a"
    }
}


