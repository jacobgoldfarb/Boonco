//
//  DescriptionPromptView.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-28.
//  Copyright © 2020 Jacob Goldfarb. All rights reserved.
//

import UIKit

class DescriptionPromptView: UIView {
    
    //MARK: UIElements and Constants
    
    var descriptionPromptLabel: Label!
    var descriptionTextView: TextView!
    
    private let descriptionPrompt = "Description"
    private let descriptionPlaceholder = "Enter a description..."
    
    let viewBackgroundColor = UIColor.clear
    
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
        backgroundColor = viewBackgroundColor
        initiateSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    private func initiateSubviews() {
        descriptionPromptLabel = Label()
        descriptionTextView = TextView()
    }
    
    private func setupSubviews() {
        setupDescriptionPromptLabel()
        setupDescriptionTextView()
        addSubviews(descriptionPromptLabel, descriptionTextView)
    }
    
    private func setupDescriptionPromptLabel() {
        descriptionPromptLabel.text = descriptionPrompt
        descriptionPromptLabel.font = Theme.standard.font.header
    }

    private func setupDescriptionTextView() {
        descriptionTextView.placeholder = descriptionPlaceholder
        descriptionTextView.textContainer.maximumNumberOfLines = 8
        descriptionTextView.textContainer.lineBreakMode = .byWordWrapping
        descriptionTextView.isUserInteractionEnabled = true
    }
}

//MARK: Constraints

extension DescriptionPromptView {
    
    private func setupConstraints() {
        setupConstraintsForDescriptionPromptLabel()
        setupConstraintsForDescriptionTextView()
    }
    
    private func setupConstraintsForDescriptionPromptLabel() {
        descriptionPromptLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview()
            make.height.greaterThanOrEqualTo(15)
        }
    }
    
    private func setupConstraintsForDescriptionTextView() {
        descriptionTextView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionPromptLabel.snp.bottom)
            make.width.equalToSuperview().inset(24)
            make.height.equalTo(204)
            make.bottom.lessThanOrEqualToSuperview().offset(-5)
        }
    }
}
