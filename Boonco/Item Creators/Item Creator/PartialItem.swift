//
//  PartialItem.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-02.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit.UIImage

protocol PartialItem: Codable {
    var owner: User? { get set }
    var title: String? { get set }
    var price: Double? { get set }
    var description: String? { get set }
    var timeframe: TimeInterval? { get set }
    var status: ItemStatus { get set }
    var category: Category? { get set }
    var thumbnailImage: UIImage? { get }
    var itemImages: [UIImage]?  { get set }
    
}
