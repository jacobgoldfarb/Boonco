//
//  EditProfileDetailView.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-09.
//  Copyright © 2020 Project PJ. All rights reserved.
//

// Notes: Start with a generic edit name, edit location/postal code detail view
//        do the edit profile picture/upload one at the end

// TODO: Get the keyboard to pop the done button and fields up upon keyboard is active
//       Basically slides up the modal just like how Uber does it

import UIKit

class EditProfileDetailView: UIView {
    
    //MARK: UIElements and Constants
    
    var detailLabel: Label!
    var detailTextField: TextField!
    var updateDetailButton: SecondaryButton!
    var errorLabel: Label!
    var editProfileDetailType: EditableProfileDetail = .edit
    
    let viewBackgroundColor = UIColor.white
    let textfieldPlaceholder = "Edit"
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    init(of editDetailType: EditableProfileDetail = .edit) {
        super.init(frame: CGRect.zero)
        self.editProfileDetailType = editDetailType
        setupView()
    }
    
    //MARK: Setup view
    
    private func setupView() {
        backgroundColor = viewBackgroundColor
        initiateSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: Subview Setup
    
    private func initiateSubviews() {
        detailLabel = Label()
        detailTextField = TextField()
        updateDetailButton = SecondaryButton()
        errorLabel = Label()
    }
    
    private func setupSubviews() {
        setupDetailLabel(detailLabel, withText: editProfileDetailType.labelText)
        setupDetailTextField(detailTextField, editProfileDetailType.textfieldPlaceholder)
        setupUpdateButton(updateDetailButton, withText: editProfileDetailType.buttonText)
        setupErrorLabel(errorLabel)
    }
    
    private func setupDetailLabel(_ label: UILabel, withText text: String) {
        label.text = text
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.clipsToBounds = true
        addSubview(label)
    }
    
    private func setupDetailTextField(_ textfield: UITextField, _ placeholder: String) {
        textfield.placeholder = placeholder
        textfield.textAlignment = .left
        textfield.sizeToFit()
        textfield.keyboardType = .default //will need to be dynamic
        textfield.autocapitalizationType = .words
        addSubview(textfield)
    }
    
    private func setupUpdateButton(_ button: SecondaryButton, withText text: String) {
        button.setTitle(text, for: .normal)
        addSubview(button)
    }
    
    private func setupErrorLabel(_ label: UILabel) {
        label.text = ""
        label.textColor = .red
        label.font = label.font.withSize(15)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.clipsToBounds = true
        addSubview(label)
    }
}

//MARK: Constraints

extension EditProfileDetailView {
    private func setupConstraints() {
        setupConstraintsForLabel(detailLabel)
        setupConstraintsForTextfield(detailTextField)
        setupConstraintsForUpdateButton(updateDetailButton)
        setupConstraintsForErrorLabel(errorLabel)
    }
    
    private func setupConstraintsForLabel(_ label: UILabel) {
        label.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(30)
            make.centerY.equalToSuperview().offset(-50)
            make.height.equalTo(30)
        }
    }
    
    private func setupConstraintsForTextfield(_ textfield: UITextField) {
        textfield.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(detailLabel.snp.bottom).offset(20)
            make.height.greaterThanOrEqualTo(20)
            make.height.lessThanOrEqualTo(50)
        }
    }
    
    private func setupConstraintsForUpdateButton(_ button: SecondaryButton) {
        button.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(48)
        }
    }
    
    private func setupConstraintsForErrorLabel(_ errorLabel: UILabel) {
        errorLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(30)
            make.height.equalTo(16)
            make.top.equalTo(detailTextField.snp.bottom).offset(16)
        }
    }
}

