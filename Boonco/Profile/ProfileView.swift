//
//  ProfileView.swift
//  Lender
//
//  Created by Peter Huang on 2020-03-31.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    //MARK: UIElements and Constants
    
    var coverPhotoImageView: UIImageView!
    var profilePhotoImageView: UIImageView!
    var nameLabel: UILabel!
    var locationLabel: UILabel!
    var ratingLabel: UILabel!
    var segmentedControl: SegmentedControl!
    var actionButton: UIButton!
    var itemsTableView: TableView!
    var settingsButton: UIButton!
    var editProfileButton: UIButton!
    var walletButton: UIButton!
    
    let segmentList: [ProfileSegment] = [.listings, .requests]
    let defaultIndex = 0
    let emptyTableViewPrompt = "Looks like you don't have any listings."
    
    //MARK: Initialization
    
    //I think the use of space in the current UI is critical,
    //we want to maximize space to see the list of our listings.
    //Profile picture to the left, description, followers/following to the right
    //so that the views are not stacked onto each other
    
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
        backgroundColor = UIColor.white
        initiateSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: Subview Setup
    
    private func initiateSubviews() {
        let profilePicDefault = Theme.standard.images.getProfilePlaceholder()
        
        coverPhotoImageView = UIImageView()
        profilePhotoImageView = UIImageView(image: profilePicDefault)
        nameLabel = UILabel()
        locationLabel = UILabel()
        ratingLabel = UILabel()
        segmentedControl = SegmentedControl(items: segmentList.map {$0.description} )
        actionButton = PrimaryButton()
        itemsTableView = TableView()
        
        settingsButton = UIButton()
        editProfileButton = UIButton()
        walletButton = UIButton()
    }
    
    private func setupSubviews() {
        setupCoverPhotoView(coverPhotoImageView)
        setupProfilePhotoView(profilePhotoImageView)
        setupProfileLabels(withName: nameLabel, withBio: locationLabel, withRating: ratingLabel)
        setupProfileSections(segmentedControl)
        setupActionButton(actionButton, title: segmentList[defaultIndex].buttonDescription)
        setupTableView(itemsTableView)
        setupSettingsButton(settingsButton)
        setupEditProfileButton(editProfileButton)
        setupWalletButton(walletButton)
    }

    private func setupCoverPhotoView(_ imageView: UIImageView) {
        imageView.backgroundColor = Theme.standard.colors.maroon
        addSubview(imageView)
    }
    
    private func setupProfilePhotoView(_ imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = Theme.standard.colors.dimGray
        addSubview(imageView)
    }
    
    private func setupProfileBorders(_ imageView: UIImageView, withDiameter diameter: Int) {
        imageView.layer.borderWidth = 2.0
        imageView.layer.cornerRadius = CGFloat(diameter / 2)
        imageView.layer.borderColor = UIColor.black.cgColor
    }
    
    private func setupProfileLabels(withName profileName: UILabel, withBio profileLocation: UILabel, withRating profileRating: UILabel) {
        profileName.textColor = UIColor.black
        profileName.highlightedTextColor = UIColor.blue
        profileName.font = Theme.standard.font.detailHeader
        profileName.numberOfLines = 1
        
        profileLocation.textColor = UIColor.darkGray
        profileLocation.font = Theme.standard.font.paragraph
        profileLocation.numberOfLines = 1
        
        profileRating.textColor = UIColor.darkGray
        profileRating.font = Theme.standard.font.paragraph
        profileRating.numberOfLines = 1
        
        addSubview(profileName)
        addSubview(profileLocation)
        addSubview(profileRating)
    }
    
    private func setupProfileSections(_ profileSC: SegmentedControl) {
        profileSC.selectedSegmentIndex = defaultIndex
        addSubview(profileSC)
    }
    
    private func setupActionButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
    }
    
    private func setupTableView(_ tableView: TableView) {
        tableView.emptyIcon = Theme.standard.images.getFolderEmptyGrey()
        tableView.emptyText = emptyTableViewPrompt
        tableView.rowHeight = 100
        tableView.updateView()
        addSubview(tableView)
    }
    
    private func setupSettingsButton(_ button: UIButton) {
        let settingsIcon = Theme.standard.images.getSettingsIcon()
        button.frame = CGRect.zero
        button.setImage(settingsIcon, for: .normal)
        addSubview(button)
    }
    
    private func setupEditProfileButton(_ button: UIButton) {
        let editProfileIcon = Theme.standard.images.getEditProfileIcon()
        button.frame = CGRect.zero
        button.setImage(editProfileIcon, for: .normal)
        addSubview(button)
    }
    
    private func setupWalletButton(_ button: UIButton) {
        let walletIcon = Theme.standard.images.getWalletIcon()
        button.frame = CGRect.zero
        button.setImage(walletIcon, for: .normal)
    }
}

//MARK: Constraints

extension ProfileView {
    private func setupConstraints() {
        setupConstraintsForCoverPhoto(coverPhotoImageView)
        setupConstraintsForProfilePhoto(profilePhotoImageView)
        setupConstraintsForProfileLabels(nameLabel: nameLabel, locationLabel: locationLabel, ratingLabel: ratingLabel)
        setupProfileSegmentedControl(segmentedControl)
        setupTableViewConstraints(itemsTableView)
        setupSettingsButtonConstraints(settingsButton)
        setupEditProfileButtonConstraints(editProfileButton)
    }
    
    private func setupConstraintsForCoverPhoto(_ imageView: UIImageView) {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(snp.height).dividedBy(5)
        }
    }
    
    private func setupConstraintsForProfilePhoto(_ imageView: UIImageView) {
        let diameter = Int(UIScreen.main.bounds.width * (0.32))
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(coverPhotoImageView.snp.bottom).inset(diameter / 5)
            make.height.width.equalTo(diameter)
        }
        setupProfileBorders(imageView, withDiameter: diameter)
    }
    
    private func setupConstraintsForProfileLabels(nameLabel: UILabel, locationLabel: UILabel, ratingLabel: UILabel) {
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profilePhotoImageView.snp.bottom).offset(5)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(locationLabel.snp.bottom)
        }
    }
    
    private func setupProfileSegmentedControl(_ profileSC: SegmentedControl) {
        profileSC.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupConstraintsForActionButton(_ button: UIButton) {
        button.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(segmentedControl.snp.bottom).offset(10)
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview().inset(18)
        }
    }
    
    private func setupTableViewConstraints(_ tableView: TableView) {
        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(segmentedControl.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupSettingsButtonConstraints(_ settings: UIButton) {
        settings.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).inset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.width.equalTo(32)
        }
    }
    
    private func setupEditProfileButtonConstraints(_ editProfile: UIButton) {
        editProfile.snp.makeConstraints { make in
            make.top.equalTo(settingsButton.snp.bottom).offset(5)
            make.trailing.equalToSuperview().inset(15)
            make.height.width.equalTo(32)
        }
    }
    
    private func setupWalletButtonConstraints(_ wallet: UIButton) {
        wallet.snp.makeConstraints { make in
            make.top.equalTo(editProfileButton.snp.bottom).offset(3)
            make.trailing.equalToSuperview().inset(15)
            make.height.width.equalTo(32)
        }
    }
}

//MARK: Populate profile fields

extension ProfileView {
    func populate(for user: User) {
        nameLabel.text = user.name
        ratingLabel.text = user.rating.description
        
        populateUserLocationLabel(for: user.address)
        
        if let profilePic = user.profilePicture {
            profilePhotoImageView.image = profilePic
        } else {
            profilePhotoImageView.sd_setImage(with: user.profilePictureURL, completed: nil)
        }
    }
    
    func populateUserLocationLabel(for address: Address) {
        var locationText = ""
        
        if let city = address.city, !city.isEmpty {
            locationText += city
        }
        
        if let state = address.subnation, !state.isEmpty {
            if !locationText.isEmpty { locationText += ", " }
            locationText += state
        }
        
        if let country = address.country, !country.isEmpty {
            if !locationText.isEmpty { locationText += ", " }
            locationText += country
        }
        
        locationLabel.text = locationText
    }
}
