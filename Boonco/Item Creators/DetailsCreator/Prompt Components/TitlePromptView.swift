//
//  TitlePromptView.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-27.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class TitlePromptView: UIView {
    
    //MARK: UIElements and constants

    var titlePromptLabel: UILabel!
    var titleEntryTextField: UITextField!
    
    private let titlePrompt = "Title"
    
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
        titlePromptLabel = Label(frame: CGRect.zero)
        titleEntryTextField = TextField(frame: CGRect.zero)
        
        titleEntryTextField.delegate = self
    }
    
    private func setupSubviews() {
        titlePromptLabel.text = titlePrompt
        titlePromptLabel.font = Theme.standard.font.header
        titlePromptLabel.sizeToFit()
        addSubviews(titlePromptLabel, titleEntryTextField)
    }
}

//MARK: Setup constraints

extension TitlePromptView {
    private func setupConstraints() {
        setupConstraintsForTitlePromptLabel()
        setupConstraintsForTitleEntryTextField()
    }
    
    private func setupConstraintsForTitlePromptLabel() {
        titlePromptLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview()
        }
    }
    
    private func setupConstraintsForTitleEntryTextField() {
        titleEntryTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(20)
        }
    }
}

//MARK: Textfield delegate

extension TitlePromptView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 27
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        return newString.length <= maxLength
    }
}
