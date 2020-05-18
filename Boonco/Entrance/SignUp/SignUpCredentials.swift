//
//  SignUpCredentials.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-12.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

struct SignUpCredentials: Codable {
    var firstName: String
    var lastName: String
    var location: String
    var email: String
    var password: String
    var confirmPassword: String
    
    var latitude: Double
    var longitude: Double
    var street: String
    var city: String
    var subNation: String
    var country: String
    
    init() {
        firstName = ""
        lastName = ""
        location = ""
        email = ""
        password = ""
        confirmPassword = ""
        latitude = 0
        longitude = 0
        street = ""
        city = ""
        subNation = ""
        country = ""
    }
}
