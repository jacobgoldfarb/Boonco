//
//  Request.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-30.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit.UIImage

struct Request: Item {
    var id: String
    var owner: User
    var distance: UInt?
    var title: String
    var price: Double
    var description: String?
    var timeframe: TimeInterval
    var createdAt: Date
    var updatedAt: Date
    var status: ItemStatus
    var category: Category
    var imageURL: URL?
    var thumbnailURL: URL?
    
    init(id: String, owner: User, distance: UInt?, title: String, price: Double, description: String?, timeframe: TimeInterval, createdAt: Date, updatedAt: Date, status: ItemStatus, category: Category) {
        self.id = id
        self.owner = owner
        self.distance = distance
        self.title = title
        self.price = price
        self.description = description
        self.timeframe = timeframe
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.status = status
        self.category = category
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RequestKeys.self)
        let _: UIImage? = nil
        id = String(try container.decode(Int.self, forKey: .id))
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String?.self, forKey: .description)
        distance = try container.decodeIfPresent(UInt?.self, forKey: .distance) as? UInt
        price = try (container.decode(Double?.self, forKey: .price) ?? 0) / 100
        owner = try container.decode(User.self, forKey: .creator)
        timeframe = try container.decode(TimeInterval?.self, forKey: .timeframe) ?? RentalPeriod.day.rawValue
        
        let createdAtString: String = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        let updatedAtString: String = try container.decodeIfPresent(String.self, forKey: .updatedAt) ?? ""
        
        let dateFormatter = DateFormatter.dateFormatter
        createdAt = dateFormatter.date(from: createdAtString) ?? Date()
        updatedAt = dateFormatter.date(from: updatedAtString) ?? Date()
        
        status = try container.decode(ItemStatus.self, forKey: .status)
        category = try container.decode(Category.self, forKey: .category)
        if let imagePath = try container.decodeIfPresent(String?.self, forKey: .imageURL) {
            imageURL = URL(string: imagePath!, relativeTo: URL(string: Environment.current))
        }
        if let thumbnailPath = try container.decodeIfPresent(String?.self, forKey: .thumbnailURL) {
            thumbnailURL = URL(string: thumbnailPath!, relativeTo: URL(string: Environment.current))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        _ = encoder.container(keyedBy: RequestKeys.self)
    }
}

enum RequestKeys: String, CodingKey {
    case id = "id"
    case title = "title"
    case creator = "creator"
    case description = "description"
    case distance = "distance"
    case price = "price_in_cents"
    case status = "status"
    case category = "category"
    case thumbnailURL = "thumbnail_url"
    case imageURL = "image_url"
    case timeframe = "base_rental_period"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
}
