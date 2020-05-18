//
//  ResizeableButton.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-16.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class ResizeableButton: UIButton {

    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude)) ?? .zero
        let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)
        return desiredButtonSize
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        backgroundColor = .white
        setTitleColor(.black, for: .normal)
        titleLabel?.font = Theme.standard.font.regular
        titleLabel?.lineBreakMode = .byWordWrapping
        titleLabel?.numberOfLines = 0
        titleLabel?.textAlignment = .center
    }

}
