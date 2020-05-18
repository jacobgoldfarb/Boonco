//
//  TOSView.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-29.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class TOSView: UIView {

    let titleLabel: UILabel = Label()
    let termsText: UITextView = UITextView()
    let agreeButton: PrimaryButton = PrimaryButton()
    let declineButton: SecondaryButton = SecondaryButton()
    let buttonsContainer: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        addSubviews(termsText, buttonsContainer, titleLabel)
        buttonsContainer.addSubviews(agreeButton, declineButton)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        backgroundColor = .white
        setupTitle()
        setupTermsText()
        setupButtons()
        setupShadowForContainer()
    }
    
    private func setupTermsText() {
        termsText.isEditable = false
        termsText.setContentOffset(CGPoint(x: 0, y: -50), animated: false)
    }
    
    private func setupTitle() {
        titleLabel.text = "Terms of Service"
        titleLabel.font = Theme.standard.font.largeHeader
        titleLabel.textColor = .black
    }
    
    private func setupButtons() {
        agreeButton.setTitle("Agree", for: .normal)
        agreeButton.backgroundColor = Theme.standard.colors.lightGray
        declineButton.setTitle("Decline", for: .normal)
        buttonsContainer.backgroundColor = .white
    }
    
    private func setupShadowForContainer() {
        buttonsContainer.layer.masksToBounds = false
        buttonsContainer.layer.shadowColor = UIColor.black.cgColor
        buttonsContainer.layer.shadowOpacity = 0.2
        buttonsContainer.layer.shadowOffset = CGSize(width: 0, height: 4)
        buttonsContainer.layer.shadowRadius = 8
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(55)
        }
        termsText.snp.makeConstraints { make in
            make.width.centerX.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(90)
            make.bottom.equalToSuperview().offset(-110)
        }
        buttonsContainer.snp.makeConstraints { make in
            make.width.centerX.bottom.equalToSuperview()
            make.height.equalTo(110)
        }
        agreeButton.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2.2)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-35)
            make.height.equalTo(44)
        }
        declineButton.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2.2)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-35)
            make.height.equalTo(44)
        }
    }
    
}
