//
//  ItemPreview.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-02.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class ItemPreview: UIView {
    
    var thumbnailView: UIImageView = UIImageView()
    private var titleLabel: UILabel = Label()
    private var priceLabel: UILabel = Label()
    private var distanceLabel: UILabel = Label()
    private var userNameLabel: UILabel = Label()
    private var userNameImageView: UIImageView = UIImageView()
    private var distanceImageView: UIImageView = UIImageView()
    private var breakView: UIView = UIView()
    
    var itemName: String! {
        didSet {
            titleLabel.text = itemName
        }
    }
    var associatedUserName: String! {
        didSet {
            userNameLabel.text = associatedUserName
        }
    }
    var price: Double! {
        didSet {
            priceLabel.text = CurrencyFormatter.getFormattedString(from: price)
        }
    }
    var distance: UInt! {
        didSet {
            distanceLabel.text = Utilities.getDistance(fromMeters: distance)
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        setupThumbnail()
        setupTitleLabel()
        setupPriceLabel()
        setupDistanceLabel()
        setupUserLabel()
        setupIcons()
        breakView.backgroundColor = Theme.standard.colors.gainsboro
        addSubviews(thumbnailView, titleLabel, priceLabel, userNameLabel, distanceLabel, userNameImageView, distanceImageView, breakView)
    }
    
    private func setupThumbnail() {
        thumbnailView.backgroundColor = .black
        thumbnailView.layer.cornerRadius = 7.5
        thumbnailView.clipsToBounds = true
    }
    
    private func setupTitleLabel() {
        titleLabel.font = Theme.standard.font.header
        titleLabel.lineBreakMode = .byTruncatingTail
    }
    
    private func setupPriceLabel() {
        priceLabel.font = Theme.standard.font.header
    }
    
    private func setupDistanceLabel() {
        distanceLabel.font = Theme.standard.font.cellSubHeader
        distanceLabel.textColor = Theme.standard.colors.gray
    }
    private func setupUserLabel() {
        userNameLabel.font = Theme.standard.font.cellSubHeader
        userNameLabel.textColor = Theme.standard.colors.gray
    }
    
    private func setupIcons() {
        userNameImageView.image = Theme.standard.images.getTinyUser()
        distanceImageView.image = Theme.standard.images.getTinyPin()
        userNameImageView.contentMode = .scaleAspectFit
        distanceImageView.contentMode = .scaleAspectFit
    }
    
    private func setupConstraints() {
        setupConstraintsForThumbnail()
        setupConstraintsForTitle()
        setupConstraintsForPriceLabel()
        setupConstraintsForAssociatedUserLabel()
        setupConstraintsForDistanceLabel()
        setupConstraintsForUserIcon()
        setupConstraintsForPinIcon()
        setupConstraintsForBreakView()
    }
    
    private func setupConstraintsForThumbnail() {
        thumbnailView.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
    }
    
    private func setupConstraintsForTitle() {
        titleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(120)
            make.trailing.equalTo(snp.trailing).offset(-130)
            make.height.equalTo(20)
        }
    }
    
    private func setupConstraintsForPriceLabel() {
        priceLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-50)
        }
    }
    
    private func setupConstraintsForAssociatedUserLabel() {
        userNameLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalTo(userNameImageView).offset(25)
        }
    }
    
    private func setupConstraintsForDistanceLabel() {
        distanceLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(65)
            make.leading.equalTo(distanceImageView).offset(25)
        }
    }
    
    private func setupConstraintsForUserIcon() {
        userNameImageView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(120)
            make.height.width.equalTo(12)
        }
    }
    
    private func setupConstraintsForPinIcon() {
        distanceImageView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(65)
            make.leading.equalToSuperview().offset(120)
            make.height.width.equalTo(14)
        }
    }
    
    private func setupConstraintsForBreakView() {
        breakView.snp.remakeConstraints { make in
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-1)
        }
        
    }
}
