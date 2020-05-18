//
//  ContactInfoView.swift
//  Boonco
//
//  Created by Jacob Goldfarb on 2020-04-16.
//

import UIKit

class ContactInfoView: UIView {

    var phoneNumberButton: ResizeableButton = ResizeableButton()
    var emailButton: ResizeableButton = ResizeableButton()
    private var promptLabel: UILabel = Label()
    private var phoneIconView: UIImageView = UIImageView()
    private var emailIconView: UIImageView = UIImageView()
    
    private var phoneIcon: UIImage = Theme.standard.images.getPhoneIcon()
    private var emailIcon: UIImage = Theme.standard.images.getEmailIcon()
    
    var phoneNumber: String? {
        didSet {
            phoneNumberButton.setTitle(phoneNumber, for: .normal)
            setPhoneNumberHidden(phoneNumber == nil ? true : false)
        }
    }
    var email: String? {
        didSet {
            emailButton.setTitle(email, for: .normal)
        }
    }
    private var prompt: String = "Contact the user to fufill your request."
    
    init() {
        super.init(frame: CGRect.zero)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        setupPromptLabel()
        setupPhoneIcon()
        setupEmailIcon()
        addSubviews(promptLabel, phoneNumberButton, emailButton, phoneIconView, emailIconView)
    }
    
    private func setupPromptLabel() {
        promptLabel.text = prompt
        promptLabel.textAlignment = .center
    }
    
    func setPhoneNumberHidden(_ bool: Bool) {
        phoneNumberButton.isHidden = bool
        phoneIconView.isHidden = bool
    }

    
    private func setupPhoneIcon() {
        phoneIconView.image = phoneIcon
        phoneIconView.contentMode = .scaleAspectFit
    }
    
    private func setupEmailIcon() {
        emailIconView.image = emailIcon
        emailIconView.contentMode = .scaleAspectFit
    }
    
    private func setupConstraints() {
        setupConstraintsForPhoneButton()
        setupConstraintsForEmailButton()
        setupConstraintsForPhoneIcon()
        setupConstraintsForEmailIcon()
        setupConstraintsForPromptLabel()
    }
    
    private func setupConstraintsForPhoneButton() {
        phoneNumberButton.snp.remakeConstraints { make in
            make.centerX.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(10)
            make.width.lessThanOrEqualTo(snp.width).inset(20)
        }
    }
    
    private func setupConstraintsForEmailButton() {
        emailButton.snp.remakeConstraints { make in
            make.centerX.equalToSuperview().offset(20)
            make.top.equalTo(phoneNumberButton.snp.bottom).offset(5)
            make.width.lessThanOrEqualTo(snp.width).inset(20)
        }
    }
    
    private func setupConstraintsForPhoneIcon() {
        phoneIconView.snp.remakeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalTo(phoneNumberButton.snp.centerY)
            make.trailing.equalTo(phoneNumberButton.snp.leading).offset(-10)
        }
    }
    
    private func setupConstraintsForEmailIcon() {
        emailIconView.snp.remakeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalTo(emailButton.snp.centerY)
            make.trailing.equalTo(emailButton.snp.leading).offset(-10)
        }
    }
    
    private func setupConstraintsForPromptLabel() {
        promptLabel.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
    }
}
