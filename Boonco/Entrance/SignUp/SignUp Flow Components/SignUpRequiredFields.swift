//
//  SignUpRequiredFields.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-21.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

enum SignUpRequiredFields: CustomStringConvertible, CaseIterable {
    case firstName
    case lastName
    case location
    case email
    case password
    case confirmPassword
    
    var description: String {
        switch self {
        case .firstName:
            return "First Name"
        case .lastName:
            return "Last Name"
        case .location:
            return "Address"
        case .email:
            return "Email"
        case .password:
            return "Password"
        case .confirmPassword:
            return "Confirm"
        }
    }
    
    var labelText: String {
        return "\(description):"
    }
    
    var placeholder: String {
        switch self {
        case .firstName:
            return "Jack"
        case .lastName:
            return "Smith"
        case .location:
            return "Toronto, Canada, M5V 3L9"
        case .email:
            return "example@email.com"
        case .password:
            return "Password"
        case .confirmPassword:
            return "Confirm Password"
        }
    }
}
