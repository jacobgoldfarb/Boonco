//
//  ProfilePictureView.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-10.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class ProfilePictureView: UIView {
    
    //MARK: UIElements and Constants
    
    var headerLabel: Label!
    var descriptionLabel: Label!
    var uploadPhotoButton: SecondaryButton!
    var selectedPicture: UIImageView!
    
    let headerText = "Add a new profile picture"
    let descriptionText = "Add a new profile picture or replace your existing profile picture"
    
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
        headerLabel = Label()
        descriptionLabel = Label()
        uploadPhotoButton = SecondaryButton()
        selectedPicture = UIImageView()
    }
    
    private func setupSubviews() {
        setupHeaderLabel()
        setupDescriptionLabel()
        setupUploadPictureButton()
        setupSelectedPicture()
    }
    
    private func setupHeaderLabel() {
        headerLabel.font = Theme.standard.font.largeHeader
        headerLabel.text = headerText
        headerLabel.sizeToFit()
        addSubview(headerLabel)
    }
    
    private func setupSelectedPicture() {
        selectedPicture.contentMode = .scaleAspectFit
        addSubview(selectedPicture)
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.text = descriptionText
        addSubview(descriptionLabel)
    }
    
    private func setupUploadPictureButton() {
        uploadPhotoButton.setTitle("Upload Picture", for: .normal)
        addSubview(uploadPhotoButton)
    }
}

//MARK: Constraints

extension ProfilePictureView {
    
    func setupConstraints() {
        setupConstraintsForHeaderLabel()
        setupConstraintsForDescriptionLabel()
        setupConstraintsForUploadButton()
        setupConstraintsForSelectedPicture()
    }
    
    private func setupConstraintsForHeaderLabel() {
        headerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).inset(40)
            make.leading.equalToSuperview().inset(30)
        }
    }
    
    private func setupConstraintsForDescriptionLabel() {
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(headerLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    private func setupConstraintsForUploadButton() {
        uploadPhotoButton.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(48)
        }
    }
    
    private func setupConstraintsForSelectedPicture() {
        selectedPicture.snp.makeConstraints { (make) in
            make.top.equalTo(uploadPhotoButton.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.lessThanOrEqualToSuperview().dividedBy(2)
        }
    }
}
