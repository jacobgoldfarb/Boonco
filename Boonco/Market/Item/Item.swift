//
//  Item.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-31.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

protocol Item: Decodable {
    var id: String { get set }
    var owner: User { get set }
    var distance: UInt? { get set }
    var title: String { get set }
    var price: Double { get set }
    var description: String? { get set }
    var timeframe: TimeInterval { get set }
    var createdAt: Date { get set }
    var updatedAt: Date { get set }
    var status: ItemStatus { get set }
    var category: Category { get set }
    var thumbnailURL: URL? { get set }
    var imageURL: URL? {get set}
}

extension Item {
    func foo() -> Bool {
        return true
    }
}

enum ItemType: String, Codable {
    case rental = "Rental"
    case request = "Request"
}
