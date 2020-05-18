//
//  RentalPeriods.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-20.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

enum RentalPeriod: TimeInterval, CaseIterable {
    case hour = 3_600
    case day = 86_400
    case week = 604_800
    case other = 69

    var dropDownPrompt: String {
        switch self {
        case .hour:
            return " /hour "
        case .day:
            return " /day "
        case .week:
            return " /week "
        case .other:
            return " /other"
        }
    }
    
    ///This is used in label texts across tableviewcells and item description views
    var labelText: String {
        switch self {
        case .hour:
            return "/hour"
        case .day:
            return "/day"
        case .week:
            return "/week"
        case .other:
            return "/custom"
        }
    }
}
