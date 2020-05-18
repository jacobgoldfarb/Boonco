//
//  RoundImageView.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-24.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {

    override var bounds: CGRect {
        didSet {
            layer.masksToBounds = true
            layer.cornerRadius = min(bounds.width, bounds.height) / 2
        }
    }
}
