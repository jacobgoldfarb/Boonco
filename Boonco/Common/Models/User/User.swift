//
//  User.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-11.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit.UIImage

struct User {
    var id: String
    var name: String {
        return "\(firstName) \(lastName)"
    }
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String?
    var address: Address
    var rating: UserRating
    var profilePicture: UIImage?
    var profilePictureURL: URL?

    //MARK: Inits
    
    init(id: String, firstName: String, lastName: String, email: String,
         phoneNumber: String, location: String,
         rating: UserRating,
         address: Address? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.rating = rating
        if let address = address {
            self.address = address
        } else {
            self.address = Address(street: nil, city: nil, subnation: nil, country: nil)
        }
    }
}

//MARK: Extensions

extension User: Codable {
    public enum UserCodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case address = "address"
        case rating = "rating"
        case phoneNumber = "phone"
        case profilePictureURL = "profile_picture_url"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        id = String(try container.decode(Int.self, forKey: .id))
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        email = try container.decode(String.self, forKey: .email)
        address = try container.decode(Address.self, forKey: .address)
        phoneNumber = try container.decode(String?.self, forKey: .phoneNumber)
        rating = try container.decode(UserRating.self, forKey: .rating)
        if let imagePath = try container.decodeIfPresent(String?.self, forKey: .profilePictureURL) {
            profilePictureURL = URL(string: imagePath!, relativeTo: URL(string: Environment.current))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserCodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(email, forKey: .email)
        try container.encode(rating, forKey: .rating)
        try container.encode(address, forKey: .address)
        try container.encode(phoneNumber, forKey: .phoneNumber)
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
