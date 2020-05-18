//
//  MyListingTableViewCell.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-29.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit
import SnapKit

class ItemTableViewCell: UITableViewCell {
    
    var thumbnailView: UIImageView = UIImageView()
    private var titleLabel: UILabel = Label()
    private var priceLabel: UILabel = Label()
    private var durationLabel: UILabel = Label()
    private var userNameLabel: UILabel = Label()
    private var distanceLabel: UILabel = Label()
    private var userNameIcon: UIImageView = UIImageView()
    private var distanceIcon: UIImageView = UIImageView()
    
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
    var duration: TimeInterval! {
        didSet {
            let rentalPeriod: RentalPeriod = Utilities.convertTimeframeToRentalPeriod(withTimeframe: duration)
            durationLabel.text = rentalPeriod.labelText
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupSubviews() {
        setupThumbnail()
        setupTitleLabel()
        setupPriceLabel()
        setupDurationLabel()
        setupDistanceLabel()
        setupUserLabel()
        setupIcons()
        contentView.addSubviews(thumbnailView, priceLabel, durationLabel, titleLabel, userNameLabel, distanceLabel, userNameIcon, distanceIcon)
    }
    
    private func setupThumbnail() {
        thumbnailView.backgroundColor = .black
        thumbnailView.contentMode = .scaleAspectFill
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
    
    private func setupDurationLabel() {
        durationLabel.font = Theme.standard.font.regular
        durationLabel.numberOfLines = 1
        durationLabel.adjustsFontSizeToFitWidth = true
        durationLabel.baselineAdjustment = .alignCenters
        durationLabel.textAlignment = .left
    }
    
    private func setupUserLabel() {
        userNameLabel.font = Theme.standard.font.cellSubHeader
        userNameLabel.textColor = Theme.standard.colors.gray
    }
    
    private func setupDistanceLabel() {
        distanceLabel.font = Theme.standard.font.cellSubHeader
        distanceLabel.textColor = Theme.standard.colors.gray
    }
    
    private func setupIcons() {
        userNameIcon.image = Theme.standard.images.getTinyUser()
        distanceIcon.image = Theme.standard.images.getTinyPin()
        userNameIcon.contentMode = .scaleAspectFit
        distanceIcon.contentMode = .scaleAspectFit
    }
    
    private func setupConstraints() {
        setupConstraintsForThumbnail()
        setupConstraintsForTitle()
        setupConstraintsForPriceLabel()
        setupConstraintsForDurationLabel()
        setupConstraintsForAssociatedUserLabel()
        setupConstraintsForDistanceLabel()
        setupConstraintsForUserIcon()
        setupConstraintsForPinIcon()
    }
    
    private func setupConstraintsForThumbnail() {
        thumbnailView.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(84)
            make.width.equalTo(84)
        }
    }
    
    private func setupConstraintsForTitle() {
        titleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(thumbnailView.snp.trailing).offset(16)
            make.trailing.equalTo(priceLabel.snp.leading).offset(-12)
            make.height.equalTo(20)
        }
    }
    
    private func setupConstraintsForPriceLabel() {
        priceLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.width.lessThanOrEqualTo(84)
            make.trailing.equalToSuperview().offset(-60)
        }
    }
    
    private func setupConstraintsForDurationLabel() {
        durationLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(priceLabel.snp.centerY)
            make.leading.equalTo(priceLabel.snp.trailing).offset(1)
            make.trailing.equalToSuperview().offset(-12)
        }
    }
    
    private func setupConstraintsForAssociatedUserLabel() {
        userNameLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(45)
            make.leading.equalTo(userNameIcon.snp.trailing).offset(8)
        }
    }
    
    private func setupConstraintsForDistanceLabel() {
        distanceLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(65)
            make.leading.equalTo(distanceIcon.snp.trailing).offset(8)
        }
    }
    
    private func setupConstraintsForUserIcon() {
        userNameIcon.snp.remakeConstraints { make in
            make.top.equalTo(userNameLabel.snp.top)
            make.leading.equalTo(thumbnailView.snp.trailing).offset(16)
            make.height.width.equalTo(12)
        }
    }
    
    private func setupConstraintsForPinIcon() {
        distanceIcon.snp.remakeConstraints { make in
            make.top.equalTo(distanceLabel.snp.top)
            make.leading.equalTo(thumbnailView.snp.trailing).offset(16)
            make.height.width.equalTo(13)
        }
    }
}
