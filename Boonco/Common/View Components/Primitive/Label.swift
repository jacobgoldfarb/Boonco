//
//  Label.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-28.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class Label: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = Theme.standard.font.regular
        makeLabelAlwaysWordWrap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func makeLabelAlwaysWordWrap() {
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
    }
}
