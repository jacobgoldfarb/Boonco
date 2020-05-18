//
//  AuthenticationErrors.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-25.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

enum LRError: Error, CustomStringConvertible {
    
    //MARK: - Entrance
    
    case passwordTooShort
    case passwordsDoNotMatch
    case invalidEmailFormat
    case missingNames
    case missingLocation
    case invalidLocation
    case missingEmailOrPassword
    case emailTaken
    case wrongCredentials
    
    //MARK: - Item Creation
    
    case absentTitle
    case absentDescription
    case invalidPrice
    case invalidDuration
    
    //MARK: - Network Errors
    
    case imageConversionError
    case notAuthenticated
    case malformedOffering
    case actionAlreadyDone
    case encodingError
    case general

    
    var description: String {
        switch self {
        case .missingNames:
            return "Please enter your first and last name."
        case .missingLocation:
            return "Please enter your location or a nearby major city."
        case .invalidLocation:
            return "Please enter a valid location"
        case .missingEmailOrPassword:
            return "Please enter an email and password."
        case .passwordTooShort:
            return "Password too short"
        case .passwordsDoNotMatch:
            return "Passwords do not match"
        case .invalidEmailFormat:
            return "Invalid email format"
        case .emailTaken:
            return "Email address is already in use."
        case .wrongCredentials:
            return "Either email or password is incorrect."
        case .actionAlreadyDone:
            return "This action has already been completed."
        case .absentTitle:
            return "Please fill in a title for the item posting."
        case .absentDescription:
            return "Please fill in a description for the item posting."
        case .invalidPrice:
            return "The price you've entered is too high, please enter a price under $10,000."
        case .invalidDuration:
            return "Please enter a valid duration for the item listing."
        default:
            return "Error"
        }
    }
}
