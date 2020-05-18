//
//  PricePromptView.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-28.
//  Copyright © 2020 Jacob Goldfarb. All rights reserved.
//

import UIKit

class PricePromptView: UIView {
    
    //MARK: UIElements and Constants
    
    var pricePromptLabel: UILabel!
    var priceEntryTextField: UITextField!
    
    private let pricePrompt = "Price"
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //MARK: Setup view
    
    private func setupView() {
        initiateSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    private func initiateSubviews() {
        pricePromptLabel = Label(frame: CGRect.zero)
        priceEntryTextField = TextField(frame: CGRect.zero)
    }
    
    private func setupSubviews() {
        setupPricePromptLabel()
        setupPriceEntryTextField()
        addSubviews(pricePromptLabel, priceEntryTextField)
    }
    
    private func setupPricePromptLabel() {
        pricePromptLabel.text = pricePrompt
        pricePromptLabel.font = Theme.standard.font.header
        pricePromptLabel.sizeToFit()
    }
    
    private func setupPriceEntryTextField() {
        priceEntryTextField.text = "$ "
    }
}

//MARK: Constraints

extension PricePromptView {
    
    private func setupConstraints() {
        setupConstraintsForPricePromptLabel()
        setupConstraintsForPriceEntryTextField()
    }
    
    private func setupConstraintsForPricePromptLabel() {
        pricePromptLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview()
        }
    }
    
    private func setupConstraintsForPriceEntryTextField() {
        priceEntryTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(20)
        }
    }
}
