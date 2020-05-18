//
//  BiddedItemTableViewCell.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-03.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class BiddedMarketItemTableViewCell: UITableViewCell {
    
    var thumbnailView: UIImageView = UIImageView()
    private var titleLabel: UILabel = Label()
    private var priceLabel: UILabel = Label()
    private var durationLabel: UILabel = Label()
    private var userNameLabel: UILabel = Label()
    private var statusLabel: UILabel = Label()
    private var userNameIcon: UIImageView = UIImageView()
    private var statusIconIcon: UIImageView = UIImageView()
    
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
    var status: ItemStatus! {
        didSet {
            statusLabel.text = status.description
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
        setupUserLabel()
        setupStatusLabel()
        setupIcons()
        contentView.addSubviews(thumbnailView, priceLabel, durationLabel, titleLabel, userNameLabel, statusLabel, userNameIcon, statusIconIcon)
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
    
    private func setupDurationLabel() {
        durationLabel.font = Theme.standard.font.small
        durationLabel.textColor = Theme.standard.colors.gray
        durationLabel.numberOfLines = 1
        durationLabel.adjustsFontSizeToFitWidth = true
        durationLabel.baselineAdjustment = .alignCenters
        durationLabel.textAlignment = .left
    }
    
    private func setupStatusLabel() {
        statusLabel.font = Theme.standard.font.cellSubHeader
        statusLabel.textColor = Theme.standard.colors.gray
    }
    private func setupUserLabel() {
        userNameLabel.font = Theme.standard.font.cellSubHeader
        userNameLabel.textColor = Theme.standard.colors.gray
    }
    
    private func setupIcons() {
        userNameIcon.image = Theme.standard.images.getTinyUser()
        userNameIcon.contentMode = .scaleAspectFit
        statusIconIcon.image = Theme.standard.images.getStatusIcon()
        statusIconIcon.contentMode = .scaleAspectFit
    }
    
    private func setupConstraints() {
        setupConstraintsForThumbnail()
        setupConstraintsForTitle()
        setupConstraintsForPriceLabel()
        setupConstraintsForDurationLabel()
        setupConstraintsForAssociatedUserLabel()
        setupConstraintsForDistanceLabel()
        setupConstraintsForUserIcon()
        setupConstraintsForStatusIcon()
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
        statusLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(65)
            make.leading.equalTo(statusIconIcon.snp.trailing).offset(8)
        }
    }
    
    private func setupConstraintsForUserIcon() {
        userNameIcon.snp.remakeConstraints { make in
            make.top.equalTo(userNameLabel.snp.top)
            make.leading.equalTo(thumbnailView.snp.trailing).offset(16)
            make.height.width.equalTo(12)
        }
    }
    
    private func setupConstraintsForStatusIcon() {
        statusIconIcon.snp.remakeConstraints { make in
            make.top.equalTo(statusLabel.snp.top)
            make.leading.equalTo(thumbnailView.snp.trailing).offset(16)
            make.height.width.equalTo(13)
        }
    }
}
