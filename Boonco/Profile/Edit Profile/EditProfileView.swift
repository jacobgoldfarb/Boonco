//
//  EditProfileView.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-04.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class EditProfileView: UIView {
    
    //MARK: UIElements and Constants

    //TODO: Add profile picture and edit picture button
    var editProfilePictureButton: UIButton!
    var tableView: UITableView!
    
    let viewBackgroundColor = UIColor.white
    let componentsList: [EditableProfileDetail] = [.firstName, .lastName, .phoneNumber, .password, .location]
    let componentsHeight = 42
    
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
    
    // MARK: Subview Setup
    
    private func initiateSubviews() {
        editProfilePictureButton = PrimaryButton()
        tableView = UITableView(frame: .zero, style: .plain)
    }
    
    private func setupSubviews() {
        setupEditProfilePictureButton(editProfilePictureButton)
        setupTableView(tableView)
    }
    
    private func setupEditProfilePictureButton(_ button: UIButton) {
        //TODO: set up the button icon here
        button.setTitle("Upload profile picture", for: .normal)
        addSubview(button)
    }
    
    private func setupTableView(_ table: UITableView) {
        table.backgroundColor = viewBackgroundColor
        addSubview(table)
    }
}

//MARK: Constraints

//TODO: disable tableview scrolling

extension EditProfileView {
    private func setupConstraints() {
        setupConstraintsForEditProfilePictureButton(editProfilePictureButton)
        setupConstraintsForTableView(tableView)
    }
    
    private func setupConstraintsForEditProfilePictureButton(_ button: UIButton) {
        button.snp.makeConstraints { make in
            //make.height.width.equalTo(20)
            make.height.equalTo(48)
            //make.leading.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).inset(20)
        }
    }
    
    private func setupConstraintsForTableView(_ table: UITableView) {
        let totalComponentsHeight = componentsHeight * componentsList.count
        
        table.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(editProfilePictureButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(totalComponentsHeight)
        }
    }
}

