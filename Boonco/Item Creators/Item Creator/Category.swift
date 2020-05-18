//
//  Category.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-30.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

enum Category: String, CustomStringConvertible, Codable, CaseIterable {
    case music = "music"
    case electronics = "electronics"
    case appliances = "appliances"
    case clothes = "clothes"
    case furniture = "furniture"
    case bikes = "bikes"
    case books = "books"
    case freeStuff = "free_stuff"
    case jewellery = "jewellery"
    case games = "games"
    case other = "other"
    
    var description: String {
        switch self {
        case .music:
            return "Music"
        case .electronics:
            return "Electronics"
        case .appliances:
            return "Appliances"
        case .other:
            return "Other"
        case .clothes:
            return "Clothes"
        case .furniture:
            return "Furniture"
        case .bikes:
            return "Bikes"
        case .books:
            return "Books"
        case .freeStuff:
            return "Free Stuff"
        case .jewellery:
            return "Jewellery & Watches"
        case .games:
            return "Toys & Games"
        }
    }
}
