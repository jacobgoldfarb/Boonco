//
//  AcceptedBidProfilePreview.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-16.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class AcceptedBidProfilePreview: ProfilePreview {
    
    let contactInfoView: ContactInfoView = ContactInfoView()
    
    override func setupSubviews() {
        super.setupSubviews()
        addSubview(contactInfoView)
    }
    
    override func setupConstraints() {
        setupConstraintsForProfilePictureImageView()
        setupConstraintsForAdditionalOptionsButton()
        setupConstraintsForNameLabel()
        setupConstraintsForLocationLabel()
        setupConstraintsForRatingLabel()
        setupConstraintsForContactLabel()
        setupConstraintsForContactInfo()
    }
    
    func setupConstraintsForContactInfo() {
        contactInfoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
    }
}
