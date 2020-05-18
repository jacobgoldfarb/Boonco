//
//  ProfileSegment.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-02.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

enum ProfileSegment: CustomStringConvertible {
    case listings
    case requests
    case history
    case blank
    
    var description: String {
        switch self {
        case .listings:
            return "Listings"
        case .requests:
            return "Requests"
        case .history:
            return "History"
        case .blank:
            return "Under construction"
        }
    }
    
    var buttonDescription: String {
        switch self {
        case .listings:
            return "Create a Listing"
        case .requests:
            return "Create a Request"
        case .history:
            return "Filter History"
        case .blank:
            return "Under Construction"
        }
    }
}
