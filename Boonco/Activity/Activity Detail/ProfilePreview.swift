//
//  ProfilePreview.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-02.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class ProfilePreview: UIView {
    
    //MARK: Constants and UIElements
    
    let profilePictureImageView: RoundImageView = RoundImageView()
    let nameLabel: UILabel = Label()
    let locationLabel: UILabel = Label()
    let ratingLabel: UILabel = Label()
    let contactLabel: UILabel = Label()
    let additionalOptionsButton: UIButton = UIButton()
    
    override var bounds: CGRect {
        didSet {
            setupLayer()
        }
    }
    
    var rating: String! {
        didSet {
            ratingLabel.text = rating
        }
    }
    var name: String! {
        didSet {
            nameLabel.text = name
        }
    }
    var location: String! {
        didSet {
            locationLabel.text = location
        }
    }
    
    //MARK: Initialization
    
    init() {
        super.init(frame: CGRect.zero)
        setupLayer()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup view
    
    func setupLayer() {
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 15).cgPath
        layer.masksToBounds = false
    }
    
    func setupSubviews() {
        backgroundColor = .white
        setupLabel(nameLabel, with: Theme.standard.font.largeHeader)
        setupLabel(locationLabel)
        setupLabel(ratingLabel)
        setupLabel(contactLabel, aligned: .natural)
        setupImageView(profilePictureImageView)
        setupAdditionalOptionsButton(additionalOptionsButton)
        addSubviews(nameLabel, locationLabel, ratingLabel, contactLabel, profilePictureImageView, additionalOptionsButton)
    }
    
    func setupLabel(_ label: UILabel, with font: UIFont = Theme.standard.font.regular,
                    aligned alignment: NSTextAlignment = .center) {
        label.font = font
        label.textAlignment = alignment
    }
    
    func setupImageView(_ imageView: UIImageView) {
        profilePictureImageView.backgroundColor = Theme.standard.colors.dimGray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.bounds.width / 2
    }
    
    //TODO: Peter will create a subcomponent of this button later
    func setupAdditionalOptionsButton(_ button: UIButton) {
        let buttonImage = Theme.standard.images.getAdditionalOptionsIcon()
        button.setImage(buttonImage, for: .normal)
    }
    
    //MARK: Constraints
    
    func setupConstraints() {
        setupConstraintsForProfilePictureImageView()
        setupConstraintsForAdditionalOptionsButton()
        setupConstraintsForNameLabel()
        setupConstraintsForLocationLabel()
        setupConstraintsForRatingLabel()
        setupConstraintsForContactLabel()
    }
    
    func setupConstraintsForProfilePictureImageView() {
        profilePictureImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(120)
            make.top.equalToSuperview().offset(20)
        }
    }
    
    func setupConstraintsForAdditionalOptionsButton() {
        additionalOptionsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.width.equalTo(32)
        }
    }
    
    func setupConstraintsForNameLabel() {
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profilePictureImageView.snp.bottom).offset(15)
        }
    }
    
    func setupConstraintsForLocationLabel() {
        locationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
    }
    
    func setupConstraintsForRatingLabel() {
        ratingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(locationLabel.snp.bottom).offset(10)
        }
    }
    
    func setupConstraintsForContactLabel() {
        contactLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
