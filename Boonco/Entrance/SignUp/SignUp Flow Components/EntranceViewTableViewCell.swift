//
//  EntranceViewTableViewCell.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-20.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

protocol EntranceViewTableViewCellDelegate: class {
    func textField(editingDidBeginIn cell:EntranceViewTableViewCell)
    func textField(editingChangedInTextField newText: String, in cell: EntranceViewTableViewCell)
}

class EntranceViewTableViewCell: UITableViewCell {
    
    //MARK: UIElements and Constants
    
    var stackView: UIStackView!
    var textField: UITextField!
    var descriptionLabel: UILabel!
    
    var delegate: EntranceViewTableViewCellDelegate?
    
    //MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //MARK: Setup view
    
    private func setupView() {
        initiateSubviews()
        setupCell()
        setupConstraints()
    }
    
    //MARK: Setup subviews
    
    private func initiateSubviews() {
        stackView = UIStackView()
        descriptionLabel = UILabel()
        textField = UITextField()
    }
    
    private func setupCell() {
        selectionStyle = .none
        setupFieldLabel()
        setupTextField()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didSelectCell))
        addGestureRecognizer(gesture)
    }
    
    private func setupStackView() {
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 8
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.layoutSubviews()
        contentView.addSubview(stackView)
    }
    
    private func setupFieldLabel() {
        descriptionLabel.text = "Label"
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupTextField() {
        textField.textAlignment = .left
        textField.placeholder = "enter text"
        contentView.addSubview(textField)
        
        textField.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
    }
    
}

//MARK: Constraints

extension EntranceViewTableViewCell {
    private func setupConstraints() {
        setupConstraintsForLabel(descriptionLabel)
        setupConstraintsForTextfield(textField)
    }
    
    private func setupConstraintsForLabel(_ label: UILabel) {
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(105)
        }
    }
    
    private func setupConstraintsForTextfield(_ textfield: UITextField) {
        textfield.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalTo(descriptionLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}

//MARK: Actions

extension EntranceViewTableViewCell {
    @objc func didSelectCell() {
        textField?.becomeFirstResponder()
    }
    
    @objc func editingDidBegin() {
        delegate?.textField(editingDidBeginIn: self)
    }
    
    @objc func textFieldValueChanged(_ sender: UITextField) {
        if let text = sender.text {
            delegate?.textField(editingChangedInTextField: text, in: self)
        }
    }
}
