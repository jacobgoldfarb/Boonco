//
//  EmptyTableViewBackground.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-29.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class EmptyTableViewBackground: UIView {
    
    //MARK: UIElements and Constants
    
    var actionButton: PrimaryButton?
    private var iconImageView: UIImageView?
    private var promptLabel: Label?
    
    private let icon: UIImage?
    private let prompt: String?
    private let actionPrompt: String?
    
    init?(frame: CGRect, icon: UIImage?, prompt: String?, actionPrompt: String? = nil) {
        if icon == nil && prompt == nil && actionPrompt == nil {
            return nil
        }
        self.actionPrompt = actionPrompt
        self.icon = icon
        self.prompt = prompt
        super.init(frame: frame)
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup view
    
    func setupView() {
        backgroundColor = .white
    }
    
    func setupSubviews() {
        if actionPrompt != nil {
            setupActionButton()
        }
        if prompt != nil {
            setupPromptLabel()
        }
        if icon != nil {
            setupIconImageView()
        }
    }
    
    func setupActionButton() {
        actionButton = PrimaryButton()
        actionButton?.setTitle(actionPrompt, for: .normal)
        addSubview(actionButton!)
    }
    
    func setupPromptLabel() {
        promptLabel = Label()
        promptLabel?.textColor = Theme.standard.colors.darkGray
        promptLabel?.text = prompt
        addSubview(promptLabel!)
        promptLabel?.sizeToFit()
        promptLabel?.textAlignment = .center
    }
    
    func setupIconImageView() {
        iconImageView = UIImageView()
        iconImageView?.image = icon
        addSubview(iconImageView!)
    }
    
    //MARK: Setup constraints
    
    func setupConstraints() {
        if actionPrompt != nil {
            setupConstraintsForActionButton(actionButton!)
        }
        
        if icon != nil && prompt != nil {
            setupConstraintsForIconImageView(iconImageView!, promptLabel!)
        }
    }
    
    private func setupConstraintsForIconImageView(_ imageView: UIImageView, _ label: UILabel) {
        imageView.snp.remakeConstraints { make in
            let yOffset = UIScreen.main.bounds.height / -20
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(yOffset)
            make.height.width.equalTo(150)
        }
        
        label.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(-10)
            make.width.equalTo(175)
        }
    }
    
    private func setupConstraintsForActionButton(_ button: UIButton) {
        button.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(200)
        }
    }
}
