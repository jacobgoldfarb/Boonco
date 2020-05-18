//
//  ActiveBidProfilePreview.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-16.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class ActiveBidProfilePreview: ProfilePreview {

    let approveButton: UIButton = PrimaryButton()
    let rejectButton: UIButton = SecondaryButton()
    
    private let approveButtonTitle = "Approve"
    private let rejectButtonTitle = "Reject"
    
    override func setupSubviews() {
        super.setupSubviews()
        setupButtons()
        addSubviews(approveButton, rejectButton)
    }
    
    override func setupConstraints() {
        setupConstraintsForProfilePictureImageView()
        setupConstraintsForAdditionalOptionsButton()
        setupConstraintsForNameLabel()
        setupConstraintsForLocationLabel()
        setupConstraintsForRatingLabel()
        setupConstraintsForContactLabel()
        setupConstraintsForApproveButton()
        setupConstraintsForRejectButton()
    }
    
    private func setupConstraintsForApproveButton() {
        approveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-80)
        }
    }
    
    private func setupConstraintsForRejectButton() {
        rejectButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(48)
            make.top.equalTo(approveButton.snp.bottom).offset(20)
        }
    }
    
    private func setupButtons() {
        approveButton.setTitle(approveButtonTitle, for: .normal)
        rejectButton.setTitle(rejectButtonTitle, for: .normal)
    }
}
