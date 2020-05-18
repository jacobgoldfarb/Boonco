//
//  TextField.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-28.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    override var bounds: CGRect {
        didSet {
           makeUnderline()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clearButtonMode = .whileEditing
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeUnderline() {
        let bottomLine = CALayer()
        let lineOffset: CGFloat = 5
        bottomLine.frame = CGRect(x: 0.0, y: (frame.height + lineOffset), width: frame.width, height: 1.0)
        bottomLine.backgroundColor = Theme.standard.colors.darkGray.cgColor
        borderStyle = UITextField.BorderStyle.none
        layer.addSublayer(bottomLine)
    }
}
