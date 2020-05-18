//
//  SignUpView.swift
//  Lender
//
//  Created by Peter Huang on 2020-03-28.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit
import SnapKit

class SignUpView: UIView {
    
    //MARK: UIElements and Constants
    
    var imageView: UIImageView!
    var signUpTableview: UITableView!
    var errorMessageLabel: UILabel!
    
    var switchToLogInButton: UIButton!
    var signUpButton: UIButton!
    
    let signUpButtonTitle = "Sign Up"
    let logInButtonTitle = "Log in"
    
    let signUpFields: [SignUpRequiredFields] = [.firstName, .lastName, .location, .email, .password, .confirmPassword]

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
    
    // MARK: Setup subview
    
    private func initiateSubviews() {
        let image = Theme.standard.images.getProfilePlaceholder()
        imageView = UIImageView(image: image)
        
        switchToLogInButton = SecondaryButton()
        signUpTableview = UITableView()
        errorMessageLabel = Label()
        signUpButton = PrimaryButton()
    }
    
    private func setupSubviews() {
        setupSwitchToLogInButton(switchToLogInButton, title: logInButtonTitle)
        setupImageView(imageView)
        setupSignupTableview(signUpTableview)
        setupErrorMessageLabel(errorMessageLabel)
        setupSignUpButton(signUpButton, title: signUpButtonTitle)
    }
    
    func setupSwitchToLogInButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        addSubview(button)
    }
    
    private func setupImageView(_ imageView: UIImageView) {
        addSubview(imageView)
    }
    
    private func setupErrorMessageLabel(_ label: UILabel) {
        label.font = label.font.withSize(15)
        label.textColor = .red
        addSubview(label)
    }
    
    private func setupSignUpButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        addSubview(button)
    }
    
    private func setupSignupTableview(_ tableview: UITableView) {
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.alwaysBounceVertical = false
        
        let gesture = UITapGestureRecognizer(target: tableview, action: #selector(UITextView.endEditing(_:)))
        tableview.addGestureRecognizer(gesture)
        
        addSubview(tableview)
    }
}

// MARK: Constraints

extension SignUpView {
    
    private func setupConstraints() {
        setupConstraintsForSwitchToLogInButton(switchToLogInButton)
        setupConstraintsForImageView(imageView)
        setupConstraintsForTableView(signUpTableview)
        setupConstraintsForErrorMessageLabel(errorMessageLabel)
        setupConstraintsForSignUpButton(signUpButton)
    }
    
    private func setupConstraintsForSwitchToLogInButton(_ button: UIButton) {
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
            make.top.equalTo(switchToLogInButton.snp.bottom).offset(30)
            make.height.width.equalTo(snp.width).inset(140)
        }
    }
    
    private func setupConstraintsForTableView(_ tableview: UITableView) {
        tableview.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.height.equalTo(264)
        }
    }
    
    private func setupConstraintsForErrorMessageLabel(_ errorLabel: UILabel) {
        errorLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width).inset(30)
            make.top.equalTo(signUpTableview.snp.bottom).offset(20)
        }
    }
    
    private func setupConstraintsForSignUpButton(_ button: UIButton) {
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
            make.width.equalTo(snp.width).inset(18)
            make.height.equalTo(44)
        }
    }
}
