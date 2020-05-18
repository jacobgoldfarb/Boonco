//
//  UserRating.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-03.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

enum UserRating: Int, Codable {
    case oneStar = 1
    case twoStar = 2
    case threeStar = 3
    case fourStar = 4
    case fiveStar = 5
}

extension UserRating:  CaseIterable, CustomStringConvertible {
    var description: String {
        switch self {
        case .oneStar:
            return "1 Star"
        case .twoStar:
            return "2 Stars"
        case .threeStar:
            return "3 Stars"
        case .fourStar:
            return "4 Stars"
        case .fiveStar:
            return "5 Stars"
        }
    }
}
