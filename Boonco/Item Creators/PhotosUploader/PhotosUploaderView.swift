//
//  PhotosUploaderView.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-30.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class PhotosUploaderView: UIView {
    
    let instructionLabel: UILabel = Label()
    let descriptionLabel: UILabel = Label()
    let uploadPhotoButton: UIButton = SecondaryButton()
    let selectedPhotoView: UIImageView = UIImageView()
    
    let instructionText = "1. Add Photo"
    let uploadPhotoButtonTitle = "Upload Photo"
    let descriptionText = "Choose 1 photo that best shows what you're posting to the market. Posts with photos receive more attention."
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .white
    }
    
    func setupSubviews() {
        setupInstructionLabel()
        setupDescriptionLabel()
        setupUploadPhotoButton()
        setupSelectedPhotoView()
        addSubviews(uploadPhotoButton, instructionLabel, descriptionLabel, selectedPhotoView)
    }
    
    func setupConstraints() {
        setupConstraintsForInstructionLabel()
        setupConstraintsForDescriptionLabel()
        setupConstraintsForUploadButton()
        setupConstraintsForSelectedPhotoView()
    }
    
    private func setupInstructionLabel() {
        instructionLabel.font = Theme.standard.font.largeHeader
        instructionLabel.text = instructionText
        instructionLabel.sizeToFit()
    }
    
    private func setupSelectedPhotoView() {
        selectedPhotoView.backgroundColor = .black
        selectedPhotoView.layer.cornerRadius = 20
        selectedPhotoView.contentMode = .scaleAspectFit
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.text = descriptionText
    }
    
    private func setupUploadPhotoButton() {
        uploadPhotoButton.setTitle(uploadPhotoButtonTitle, for: .normal)
    }
    
    private func setupConstraintsForInstructionLabel() {
        instructionLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).inset(20)
            make.leading.equalToSuperview().offset(24)
        }
    }
    
    private func setupConstraintsForDescriptionLabel() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(instructionLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    private func setupConstraintsForUploadButton() {
        uploadPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
    }
    
    private func setupConstraintsForSelectedPhotoView() {
        selectedPhotoView.snp.makeConstraints { make in
            make.top.equalTo(uploadPhotoButton.snp.bottom).offset(30)
            make.width.equalToSuperview().inset(24)
            make.centerX.equalToSuperview()
            make.height.lessThanOrEqualToSuperview().dividedBy(2)
        }
    }
}
