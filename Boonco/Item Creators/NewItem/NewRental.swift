//
//  NewRental.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-15.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit.UIImage

struct NewRental: NewItem, Encodable {
    let image: UIImage?
    let category: Category
    let title: String
    let description: String
    let price: Double
    let timeframe: TimeInterval
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: NewRentalKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(category.rawValue, forKey: .category)
        try container.encode(Int(price * 100), forKey: .price)
        try container.encode(ItemType.rental, forKey: .type)
        try container.encode(timeframe, forKey: .timeframe)
    }
}
enum NewRentalKeys: String, CodingKey {
    case id = "id"
    case title = "title"
    case type = "type"
    case description = "description"
    case price = "price_in_cents"
    case category = "category"
    case image = "image"
    case timeframe = "base_rental_period"
}
