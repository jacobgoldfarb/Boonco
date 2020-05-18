//
//  NewItem.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-15.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit.UIImage

protocol NewItem: Encodable {
    var image: UIImage? { get }
    var category: Category { get }
    var title: String { get }
    var description: String { get }
    var price: Double { get }
    var timeframe: TimeInterval { get }
}
