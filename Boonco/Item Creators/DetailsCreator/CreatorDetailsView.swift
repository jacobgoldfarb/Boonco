//
//  CreatorDetailsView.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-28.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class CreatorDetailsView: UIView {
    
    //MARK: UIElements and Constants
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    var instructionLabel: UILabel!
    var titleComponent: TitlePromptView!
    var descriptionComponent: DescriptionPromptView!
    var priceComponent: PricePromptView!
    var postButton: PrimaryButton!
    var dropdownComponent: DropdownPromptView!
    var checklistComponent: ChecklistPromptView? = nil
    var staticComponent: UIView!
    
    private let instructionText = "3. Add Details"
    var postButtonText = "Post Request" {
        didSet {
            postButton.setTitle(postButtonText, for: .normal)
        }
    }
    
    let viewBackgroundColor = UIColor.white

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
    
    //MARK: Setup subviews
    
    private func initiateSubviews() {
        scrollView = UIScrollView()
        contentView = UIView()
        instructionLabel = Label()
        titleComponent = TitlePromptView()
        descriptionComponent = DescriptionPromptView()
        priceComponent = PricePromptView()
        dropdownComponent = DropdownPromptView()
        postButton = PrimaryButton()
        staticComponent = UIView()
    }
    
    private func setupSubviews() {
        setupInstructionLabel()
        setupScrollView()
        setupStaticComponent()
    }
    
    private func setupScrollView() {
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.bounces = true
        scrollView.addSubview(contentView)
        contentView.addSubviews(titleComponent, descriptionComponent, priceComponent, dropdownComponent)
        addSubview(scrollView)
    }
    
    private func setupInstructionLabel() {
        instructionLabel.font = Theme.standard.font.largeHeader
        instructionLabel.text = instructionText
        instructionLabel.sizeToFit()
        addSubview(instructionLabel)
    }
    
    private func setupPostButton() {
        postButton.setTitle(postButtonText, for: .normal)
        staticComponent.addSubviews(postButton)
    }
    
    private func setupStaticComponent() {
        setupPostButton()
        staticComponent.backgroundColor = .white
        setupShadowForComponent()
        addSubview(staticComponent)
    }
    
    private func setupShadowForComponent() {
        staticComponent.layer.masksToBounds = false
        staticComponent.layer.shadowColor = UIColor.black.cgColor
        staticComponent.layer.shadowOpacity = 0.2
        staticComponent.layer.shadowOffset = CGSize(width: 0, height: 4)
        staticComponent.layer.shadowRadius = 8
    }
}

//MARK: Constraints

extension CreatorDetailsView {
    private func setupConstraints() {
        setupConstraintsForScrollView()
        setupConstraintsForInstructionLabel()
        setupConstraintsForTitleComponent()
        setupConstraintsForDescriptionComponent()
        setupConstraintsForPriceComponent()
        setupConstraintsForDropdown()
        setupConstraintsForStaticComponent()
        setupConstraintsForPostButton()
    }
    
    private func setupConstraintsForInstructionLabel() {
        instructionLabel.snp.remakeConstraints { make in
            make.top.equalTo(layoutMarginsGuide.snp.topMargin).inset(20)
            make.leading.equalToSuperview().offset(24)
        }
    }
    
    private func setupConstraintsForScrollView() {
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(instructionLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(layoutMarginsGuide.snp.bottomMargin).inset(100)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.lessThanOrEqualTo(1400)
        }
    }
    
    private func setupConstraintsForTitleComponent() {
        titleComponent.snp.remakeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(contentView.snp.top).inset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupConstraintsForDescriptionComponent() {
        descriptionComponent.snp.remakeConstraints { make in
            make.top.equalTo(titleComponent.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(240)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupConstraintsForChecklistComponent() {
        checklistComponent?.snp.remakeConstraints { make in
            make.top.equalTo(descriptionComponent.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(190)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupConstraintsForDropdown() {
        dropdownComponent.snp.remakeConstraints { make in
            make.top.equalTo(descriptionComponent.snp.bottom).offset(30)
            make.trailing.equalToSuperview().offset(-24)
            make.width.equalTo(120)
            make.height.equalTo(235) //220 = 36 * 4 + 36 + 40 (add 15 for iPhone SE spacing)
            make.bottom.equalTo(contentView.snp.bottom).offset(30)
        }
    }
    
    private func setupConstraintsForPriceComponent() {
        priceComponent.snp.remakeConstraints { make in
            make.top.equalTo(descriptionComponent.snp.bottom).offset(25)
            make.leading.equalToSuperview()
            make.trailing.equalTo(dropdownComponent.snp.leading).offset(10)
            make.height.equalTo(50)
        }
    }
    
    private func setupConstraintsForStaticComponent() {
        staticComponent.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    private func setupConstraintsForPostButton() {
        postButton.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
