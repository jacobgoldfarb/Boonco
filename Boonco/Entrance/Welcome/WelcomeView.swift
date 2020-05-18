//
//  WelcomeView.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-23.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class WelcomeView: UIView {
    
    //MARK: UIElements and Constants
    
    var imageView: UIImageView!
    var welcomeLabel: UILabel!
    var logInButton: UIButton!
    var signUpButton: UIButton!
    var skipButton: UIButton!
    
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
    
    private func initiateSubviews() {
        let image = Theme.standard.images.getSplash()
        imageView = UIImageView(image: image)
        
        welcomeLabel = Label()
        logInButton = SecondaryButton()
        signUpButton = PrimaryButton()
        skipButton = SecondaryButton()
    }
    
    private func setupSubviews() {
        setupLogInButton(logInButton, title: logInButtonTitle)
        setupImageView(imageView)
        setupWelcomeLabel(welcomeLabel)
        setupSignUpButton(signUpButton, title: signUpButtonTitle)
        setupSkipButton(skipButton, title: skipButtonTitle)
    }
    
    private func setupLogInButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        addSubview(button)
    }
    
    private func setupImageView(_ imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
    }
    
    private func setupWelcomeLabel(_ label: UILabel) {
        label.text = "Start sharing today!"
        label.font = Theme.standard.font.largeHeader
        addSubview(label)
    }
    
    private func setupSignUpButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        addSubview(button)
    }
    
    private func setupSkipButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        addSubview(button)
    }
}

// MARK: Constraints

extension WelcomeView {
    
    private func setupConstraints() {
        setupConstraintsForLogInButton(logInButton)
        setupConstraintsForImageView(imageView)
        setupConstraintsForWelcomeLabel(welcomeLabel)
        setupConstraintsForSignUpButton(signUpButton)
        setupConstraintsForSkipButton(skipButton)
    }
    
    private func setupConstraintsForLogInButton(_ button: UIButton) {
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
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-bounds.height / 10)
            make.width.equalTo(snp.width).inset(70)
            make.height.equalToSuperview().dividedBy(10)
        }
    }
    
    private func setupConstraintsForWelcomeLabel(_ label: UILabel) {
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(5)
        }
    }
    
    private func setupConstraintsForSignUpButton(_ button: UIButton) {
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
