//
//  EditProfileDetail.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-11.
//  Copyright © 2020 Project PJ. All rights reserved.
//

enum EditableProfileDetail: CustomStringConvertible, CaseIterable {
    case firstName
    case lastName
    case phoneNumber
    case password
    case location
    case edit
    
    var description: String {
        switch self {
        case .firstName:
            return "First Name"
        case .lastName:
            return "Last Name"
        case .phoneNumber:
            return "Phone Number"
        case .password:
            return "Password"
        case .location:
            return "Location"
        default:
            return "Edit"
        }
    }
    
    var labelText: String {
        return "\(description):"
    }
    
    var textfieldPlaceholder: String {
        switch self {
        case .edit:
            return "Edit"
        default:
            return "Edit \(description)"
        }
    }
    
    var buttonText: String {
        switch self {
        case .edit:
            return "Update"
        default:
            return "Update \(description)"
        }
    }
}
