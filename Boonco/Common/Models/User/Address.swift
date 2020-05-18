//
//  Address.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-14.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

struct Address {
    let street: String?
    var city: String?
    let subnation: String?
    let country: String?
}

extension Address: Codable {
    public enum AddressCodingKeys: String, CodingKey {
        case street = "street"
        case city = "city"
        case subnation = "subnation"
        case country = "country"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: AddressCodingKeys.self)
        street = try values.decode(String?.self, forKey: .street)
        city = try values.decode(String?.self, forKey: .city)
        subnation = try values.decode(String?.self, forKey: .subnation)
        country = try values.decode(String?.self, forKey: .country)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AddressCodingKeys.self)
        try container.encode(street, forKey: .street)
        try container.encode(city, forKey: .city)
        try container.encode(subnation, forKey: .subnation)
        try container.encode(country, forKey: .country)
    }
}
