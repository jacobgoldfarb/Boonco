//
//  LoginView.swift
//  Lender
//
//  Created by Peter Huang on 2020-03-28.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class LoginView: UIView {

    //MARK: UIElements and Constants
    
    var imageView: UIImageView!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var fieldsStackView: UIStackView!
    var errorMessageLabel: UILabel!
    
    var switchToSignUpButton: UIButton!
    var logInButton: UIButton!
    var skipButton: UIButton!
    
    let emailPlaceholder = "Email"
    let passwordPlaceholder = "Password"
    let logInButtonTitle = "Log In"
    let signUpButtonTitle = "Sign up"
    let skipButtonTitle = "Not right now"
    
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
        backgroundColor = .white
        initiateSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: Subview Setup
    
    private func initiateSubviews() {
        let image = Theme.standard.images.getSplash()
        imageView = UIImageView(image: image)
        
        switchToSignUpButton = SecondaryButton()
        emailTextField = TextField(frame: CGRect.zero)
        passwordTextField = TextField(frame: CGRect.zero)
        fieldsStackView = UIStackView()
        errorMessageLabel = Label()
        logInButton = PrimaryButton()
        skipButton = SecondaryButton()
    }
    
    private func setupSubviews() {
        setupSwitchToSignUpButton(switchToSignUpButton, title: signUpButtonTitle)
        setupImageView(imageView)
        setupFieldsStackView()
        setupEmailField(emailTextField, placeholderText: emailPlaceholder)
        setupPasswordField(passwordTextField, placeholderText: passwordPlaceholder)
        setupErrorMessageLabel(errorMessageLabel)
        setupLogInButton(logInButton, title: logInButtonTitle)
        setupSkipButton(skipButton, title: skipButtonTitle)
    }
    
    private func setupSwitchToSignUpButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        addSubview(button)
    }
    
    private func setupImageView(_ imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
    }
    
    private func setupFieldsStackView() {
        fieldsStackView.axis = .vertical
        fieldsStackView.distribution = .equalSpacing
        addSubview(fieldsStackView)
    }
    
    private func setupEmailField(_ field: UITextField, placeholderText: String) {
        field.placeholder = placeholderText
        field.textAlignment = .left
        field.sizeToFit()
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        fieldsStackView.addArrangedSubview(field)
    }
    
    private func setupPasswordField(_ field: UITextField, placeholderText: String) {
        field.placeholder = placeholderText
        field.textAlignment = .left
        field.sizeToFit()
        field.isSecureTextEntry = true
        fieldsStackView.addArrangedSubview(field)
    }
    
    private func setupErrorMessageLabel(_ label: UILabel) {
        label.font = label.font.withSize(15)
        label.textColor = .red
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.clipsToBounds = true
        addSubview(label)
    }
    
    private func setupLogInButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        addSubview(button)
    }
    
    private func setupSkipButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        addSubview(button)
    }
}

// MARK: Constraints

extension LoginView {
    
    private func setupConstraints() {
        setupConstraintsForImageView(imageView)
        setupConstraintsForFieldsStackView(fieldsStackView)
        setupConstraintsForErrorMessageLabel(errorMessageLabel)
        setupConstraintsForLogInButton(logInButton)
        setupConstraintsForSwitchToSignUpButton(switchToSignUpButton)
        setupConstraintsForSkipButton(skipButton)
    }
    
    private func setupConstraintsForSwitchToSignUpButton(_ button: UIButton) {
        button.snp.makeConstraints { make in
            let topConstraint = (bounds.width - 200) / 3
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(topConstraint)
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalTo(44)
        }
    }
    
    private func setupConstraintsForImageView(_ imageView: UIImageView) {
        imageView.snp.makeConstraints { make in
            let bottomConstraint = -1 * ((bounds.height - bounds.width) / 2 - 120)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(fieldsStackView.snp.top).offset(bottomConstraint)
            make.height.width.equalTo(snp.width).inset(70)
        }
    }
    
    private func setupConstraintsForFieldsStackView(_ stackView: UIStackView) {
        stackView.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalToSuperview().inset(200)
            make.height.equalTo(100)
            make.width.equalTo(snp.width).inset(30)
        }
    }
    
    private func setupConstraintsForErrorMessageLabel(_ errorLabel: UILabel) {
        errorLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(fieldsStackView.snp.bottom).offset(25)
            make.width.equalTo(snp.width).inset(30)
        }
    }
    
    private func setupConstraintsForLogInButton(_ button: UIButton) {
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
            make.width.equalTo(snp.width).inset(18)
            make.height.equalTo(44)
        }
    }
    
    private func setupConstraintsForSkipButton(_ button: UIButton) {
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
            make.width.equalTo(snp.width).inset(18)
            make.height.equalTo(44)
        }
    }
}
