//
//  Bid.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-03.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

struct Bid: Codable {
    var id: String
    var status: BidStatus
    var item: Item
    let bidder: User
    
    init(id: String, status: BidStatus = .active, item: Item, user: User) {
        self.id = id
        self.status = status
        self.item = item
        self.bidder = user
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BidCodingKeys.self)
        let itemContainer = try container.nestedContainer(keyedBy: BidCodingKeys.self, forKey: .item)

        id = String(try container.decode(Int.self, forKey: .id))
        bidder = try container.decode(User.self, forKey: .bidder)
        status = try container.decode(BidStatus.self, forKey: .status)
        let itemType = try itemContainer.decode(ItemType.self, forKey: .itemType)
        switch itemType {
        case .rental:
            item = try container.decode(Rental.self, forKey: .item)
        case .request:
            item = try container.decode(Request.self, forKey: .item)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: BidCodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(status.rawValue, forKey: .status)
        try container.encode(item.id, forKey: .itemId)
        try container.encode(bidder.id, forKey: .userId)
    }
}

enum BidStatus: String, Codable {
    case active = "active"
    case rejected = "rejected"
    case inactive = "inactive"
    case accepted = "accepted"
}

public enum BidCodingKeys: String, CodingKey {
    case id = "id"
    case status = "status"
    case itemId = "item_id"
    case userId = "user_id"
    case item = "item"
    case bidder = "bidder"
    case itemType = "type"
}
