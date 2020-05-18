//
//  Status.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-30.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

enum ItemStatus: String, CustomStringConvertible, Codable {
    case open = "available"
    /// Indicates the item was biddedOn by some user for items owned by the active user. Indicates the active user biddedOn an item for items not owned by the active user.
    case biddedOn = "bidded_on"
    /// Indicates the item was approved by the item owner.
    case approved = "approved"
    case inProgress = "in_progress"
    case completed = "completed"
    
    var actionPrompt: String {
        switch self {
        case .open:
            return "Borrow/Lend"
        case .biddedOn:
            return "Cancel"
        case .approved:
            return "View Contact Info"
        case .inProgress:
            return "Finish Rental"
        default:
            return ""
        }
    }
    var description: String {
        switch self {
        case .open:
            return "Available"
        case .biddedOn:
            return "Pending Approval"
        case .approved:
            return "Approved"
        case .inProgress:
            return "Rental in Progress"
        case .completed:
            return "Rental Completed"
        }
    }
}
