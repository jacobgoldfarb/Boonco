//
//  SecondaryButton.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-29.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class SecondaryButton: UIButton {
    private let cornerRadius: CGFloat = 8
    
    override var bounds: CGRect {
        didSet {
           updateView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
        setupShadow()
        backgroundColor = .white
        setTitleColor(.black, for: .normal)
        clipsToBounds = true
        titleLabel!.font = Theme.standard.font.header
    }
    
    func updateView() {
        setupBorder()
        setupShadow()
        
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    }
    
    private func setupBorder() {
        layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
