//
//  DetailView.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-29.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class ItemDetailView: UIView {
    
    //MARK: Constants and UIElements
    
    var actionButton: UIButton!
    var additionalOptionsButton: UIButton!
    private var titleLabel: UILabel!
    private var priceLabel: UILabel!
    
    private var ownerLabel: UILabel! //TODO: indiv constants by group var
    private var timePostedLabel: UILabel!
    private var distanceLabel: UILabel!
    private var durationLabel: UILabel!
    
    private var ownerIcon: UIImageView!
    private var timePostedIcon: UIImageView!
    private var distanceIcon: UIImageView!
    
    private var imageView: UIImageView!
    private var descriptionHeaderLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var staticComponent: UIView!
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    let descriptionHeader: String = "Description"
    var title: String! {
        didSet {
            titleLabel.text = title
        }
    }
    var price: Double! {
        didSet {
            priceLabel.text = CurrencyFormatter.getFormattedString(from: price)
        }
    }
    var duration: TimeInterval! {
        didSet {
            let rentalPeriod: RentalPeriod = Utilities.convertTimeframeToRentalPeriod(withTimeframe: duration)
            durationLabel.text = rentalPeriod.labelText
        }
    }
    var ownerName: String! {
        didSet {
            ownerLabel.text = ownerName
        }
    }
    var timePosted: TimeInterval! {
        didSet {
            timePostedLabel.text = Utilities.getTimeframe(fromTimeframe: timePosted)
        }
    }
    var distance: UInt! {
        didSet {
            distanceLabel.text = Utilities.getDistance(fromMeters: distance)
        }
    }
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    var descriptionText: String! {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        initializeSubviews()
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
    
    func initializeSubviews() {
        titleLabel = Label()
        priceLabel = Label()
        durationLabel = Label()
        ownerLabel = Label()
        timePostedLabel = Label()
        distanceLabel = Label()
        ownerIcon = UIImageView()
        timePostedIcon = UIImageView()
        distanceIcon = UIImageView()
        imageView =  UIImageView()
        descriptionHeaderLabel = Label()
        descriptionLabel = Label()
        actionButton = PrimaryButton()
        staticComponent = UIView()
        scrollView = UIScrollView()
        contentView = UIView()
        additionalOptionsButton = UIButton()
    }
    
    func setupSubviews() {
        setupDurationLabel(durationLabel)
        setupPriceLabel(priceLabel)
        setupTitleLabel(titleLabel)
        setupItemPostingDetailLabel(ownerLabel)
        setupItemPostingDetailLabel(timePostedLabel)
        setupItemPostingDetailLabel(distanceLabel)
        setupItemPostingDetailIcon(ownerIcon, with: Theme.standard.images.getUserIcon())
        setupItemPostingDetailIcon(timePostedIcon, with: Theme.standard.images.getClockIcon())
        setupItemPostingDetailIcon(distanceIcon, with: Theme.standard.images.getLocationIcon())
        setupDescriptionHeaderLabel(descriptionHeaderLabel)
        setupDescriptionLabel(descriptionLabel)
        setupImageView(imageView)
        setupStaticComponent(withButton: actionButton)
        setupAdditionalOptionsButton(additionalOptionsButton)
        setupScrollView()
        addSubviews(scrollView, staticComponent)
    }
    
    func updateView(for item: Item) {
        if item.owner == AuthState.shared.getUser() {
            actionButton.setTitle("Cancel Listing", for: .normal)
            actionButton.backgroundColor = Theme.standard.colors.warning
            return
        }
        actionButton.setTitle(item.status.actionPrompt, for: .normal)
        switch item.status {
        case .open:
            actionButton.backgroundColor = Theme.standard.colors.secondary
        default:
            actionButton.backgroundColor = Theme.standard.colors.warning
        }
    }
    
    private func setupScrollView() {
        contentView.addSubviews(durationLabel, priceLabel, titleLabel, descriptionHeaderLabel, descriptionLabel, imageView, additionalOptionsButton)
        contentView.addSubviews(ownerLabel, timePostedLabel, distanceLabel)
        contentView.addSubviews(ownerIcon, timePostedIcon, distanceIcon)
        scrollView.addSubview(contentView)
        scrollView.bounces = true
    }
    
    private func setupImageView(_ imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
    }
    
    private func setupDescriptionLabel(_ label: UILabel) {
        label.font = Theme.standard.font.paragraph
        label.textColor = Theme.standard.colors.gray
        label.lineBreakMode = .byWordWrapping
    }
    
    private func setupTitleLabel(_ label: UILabel) {
        label.lineBreakMode = .byTruncatingTail
        label.font = Theme.standard.font.detailHeader
    }
    
    private func setupPriceLabel(_ label: UILabel) {
        label.font = Theme.standard.font.detailHeader
    }
    
    private func setupDurationLabel(_ label: UILabel) {
        label.font = Theme.standard.font.regularDetailHeader
    }
    
    private func setupItemPostingDetailLabel(_ label: UILabel) {
        label.lineBreakMode = .byTruncatingTail
        label.font = Theme.standard.font.paragraph
        label.textColor = Theme.standard.colors.davysGray
    }
    
    private func setupItemPostingDetailIcon(_ imageView: UIImageView, with image: UIImage) {
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
    }
    
    private func setupDescriptionHeaderLabel(_ label: UILabel) {
        label.font = Theme.standard.font.header
        label.text = descriptionHeader
    }

    private func setupStaticComponent(withButton button: UIButton) {
        staticComponent.addSubview(button)
        staticComponent.backgroundColor = .white
        setupShadowForComponent()
    }
    
    private func setupShadowForComponent() {
        staticComponent.layer.masksToBounds = false
        staticComponent.layer.shadowColor = UIColor.black.cgColor
        staticComponent.layer.shadowOpacity = 0.2
        staticComponent.layer.shadowOffset = CGSize(width: 0, height: 4)
        staticComponent.layer.shadowRadius = 8
    }
    
    private func setupAdditionalOptionsButton(_ button: UIButton) {
        let buttonImage = Theme.standard.images.getAdditionalOptionsIcon()
        button.backgroundColor = UIColor.white
        button.layer.borderColor = Theme.standard.colors.jetGray.cgColor
        button.layer.borderWidth = 2.0
        button.layer.cornerRadius = 8.0
        button.setImage(buttonImage, for: .normal)
    }
    
    // MARK: Constraints
    
    func setupConstraints() {
        setupConstraintsForStaticComponent()
        setupConstraintsForScrollView()
        setupConstraintsForImageView()
        setupConstraintsForAdditionalOptionsButton()
        
        setupConstraintsForDurationLabel()
        setupConstraintsForPriceLabel()
        setupConstraintsForTitleLabel()
    
        setupConstraintsForOwnerLabel()
        setupConstraintsForTimePostedLabel()
        setupConstraintsForLocationLabel()
        
        setupConstraintsForOwnerIcon()
        setupConstraintsForTimePostedIcon()
        setupConstraintsForDistanceIcon()
        
        setupConstraintsForDescriptionHeaderLabel()
        setupConstraintsForDescriptionLabel()
        setupConstraintsForBorrowButton()
    }
    
    private func setupConstraintsForImageView() {
        imageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.height.equalTo(snp.width)
        }
    }
    
    private func setupConstraintsForAdditionalOptionsButton() {
        additionalOptionsButton.snp.makeConstraints { make in
            make.top.equalTo(layoutMarginsGuide.snp.topMargin).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.width.equalTo(32)
        }
    }
    
    private func setupConstraintsForDurationLabel() {
        durationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(priceLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func setupConstraintsForPriceLabel() {
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.trailing.equalTo(durationLabel.snp.leading).offset(-1)
        }
    }
    
    private func setupConstraintsForTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(priceLabel.snp.leading).offset(-12)
        }
    }
    
    private func setupConstraintsForOwnerLabel() {
        ownerLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(50)
        }
    }
    
    private func setupConstraintsForTimePostedLabel() {
        timePostedLabel.snp.makeConstraints { make in
            make.top.equalTo(ownerLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(50)
        }
    }
    
    private func setupConstraintsForLocationLabel() {
        distanceLabel.snp.makeConstraints { make in
            make.top.equalTo(timePostedLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(50)
        }
    }
    
    private func setupConstraintsForOwnerIcon() {
        ownerIcon.snp.makeConstraints { make in
            make.top.equalTo(ownerLabel.snp.top)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func setupConstraintsForTimePostedIcon() {
        timePostedIcon.snp.makeConstraints { make in
            make.top.equalTo(timePostedLabel.snp.top)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func setupConstraintsForDistanceIcon() {
        distanceIcon.snp.makeConstraints { make in
            make.top.equalTo(distanceLabel.snp.top)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func setupConstraintsForDescriptionHeaderLabel() {
        descriptionHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(distanceLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func setupConstraintsForDescriptionLabel() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionHeaderLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-25)
        }
    }
    
    private func setupConstraintsForBorrowButton() {
        actionButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
    
    private func setupConstraintsForStaticComponent() {
        staticComponent.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin)
            make.width.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    
    private func setupConstraintsForScrollView() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(staticComponent.snp.top)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.lessThanOrEqualTo(1050)
        }
    }
}

// MARK: Population

extension ItemDetailView {
    func populateView(from item: Item) {
        title = item.title
        price = item.price
        duration = item.timeframe
        ownerName = item.owner.name
        timePosted = abs(item.createdAt.timeIntervalSinceNow)
        distance = item.distance
        descriptionText = item.description
        updateView(for: item)
        setupConstraints()
    }
}

// MARK: Subclasses

class ListingItemDetailView: ItemDetailView {
    override func updateView(for item: Item) {
        super.updateView(for: item)
        if item.status == .open {
            actionButton.setTitle("Borrow", for: .normal)
        }
    }
}

class RequestItemDetailView: ItemDetailView {
    override func updateView(for item: Item) {
        super.updateView(for: item)
        if item.status == .open {
            actionButton.setTitle("Lend", for: .normal)
        }
    }
}

