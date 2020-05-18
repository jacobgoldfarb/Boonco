//
//  Button.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-28.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class PrimaryButton: UIButton {

    private let cornerRadius: CGFloat = 8
    
    override var bounds: CGRect {
        didSet {
           updateView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Theme.standard.colors.secondary
        layer.cornerRadius = cornerRadius
        setupShadow(cornerRadius: cornerRadius)
        titleLabel!.font = Theme.standard.font.header
    }
    
    func updateView() {
        setupShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
