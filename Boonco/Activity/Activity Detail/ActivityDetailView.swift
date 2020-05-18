//
//  ActivityDetailView.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-02.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class ActivityDetailView: UIView {
    
    var itemPreview: ItemPreview = ItemPreview()
    var profilePreview: ProfilePreview = ActiveBidProfilePreview()
    let itemHeaderLabel: UILabel = Label()
    let profileHeaderLabel: UILabel = Label()
    let scrollView: UIScrollView = UIScrollView()
    let itemHeader = "Item"
    let profileHeader = "User Profile"

    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateProfilePreview(for status: BidStatus) {
        profilePreview.removeFromSuperview()
        switch status {
        case .accepted:
            profilePreview = AcceptedBidProfilePreview()
        case .rejected:
            let inactiveProfilePreview = InactiveProfilePreview()
            inactiveProfilePreview.header = "You've rejected this offer."
            profilePreview = inactiveProfilePreview
        case .active:
            profilePreview = ActiveBidProfilePreview()
        case .inactive:
            let inactiveProfilePreview = InactiveProfilePreview()
            inactiveProfilePreview.body = "To reveal information about this user, retract your existing approval and Approve this one."
             inactiveProfilePreview.header = "This response is inactive."
            profilePreview = inactiveProfilePreview
        }
        scrollView.addSubview(profilePreview)
        setupConstraintsForProfilePreview()
        setNeedsLayout()
    }
    
    func setupSubviews() {
        setupItemHeaderLabel()
        setupProfileHeaderLabel()
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        scrollView.addSubviews(itemPreview, profilePreview, itemHeaderLabel, profileHeaderLabel)
    }
    
    func updateView() {
        let heightExtension = 1000 / bounds.height * 30
        print(heightExtension)
        scrollView.contentSize = CGSize(width: bounds.width, height: bounds.height + heightExtension)
    }
    
    func setupConstraints() {
        setupConstraintsForScrollView()
        setupConstraintsForItemHeader()
        setupConstraintsForItemPreview()
        setupConstraintsForProfileHeader()
        setupConstraintsForProfilePreview()
    }
    
    private func setupItemHeaderLabel() {
        itemHeaderLabel.font = Theme.standard.font.largeHeader
        itemHeaderLabel.text = itemHeader
    }
    private func setupProfileHeaderLabel() {
        profileHeaderLabel.font = Theme.standard.font.largeHeader
        profileHeaderLabel.text = profileHeader
    }
    
    private func setupConstraintsForItemPreview() {
        itemPreview.snp.makeConstraints { make in
            make.width.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(80)
            make.height.equalTo(100)
        }
    }
    
    func setupConstraintsForProfilePreview() {
        profilePreview.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(40)
            make.top.equalTo(profileHeaderLabel.snp.bottom).offset(5)
            make.height.equalTo(400)
        }
    }
    
    private func setupConstraintsForItemHeader() {
        itemHeaderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
        }
    }
    
    private func setupConstraintsForProfileHeader() {
        profileHeaderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(itemPreview.snp.bottom).offset(20)
        }
    }
    
    private func setupConstraintsForScrollView() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: Population

extension ActivityDetailView {
    func populateProfileView(from user: User) {
        profilePreview.name = user.name
        profilePreview.location = user.address.city
        profilePreview.rating = user.rating.description
        profilePreview.profilePictureImageView.sd_setImage(with: user.profilePictureURL)        
    }
    
    func populateItemView(from item: Item) {
        itemPreview.associatedUserName = item.owner.name
        itemPreview.distance = item.distance
        itemPreview.itemName = item.title
        itemPreview.price = item.price
        itemPreview.thumbnailView.sd_setImage(with: item.thumbnailURL, completed: nil)
    }

    func populateAcceptedProfileView(for user: User) {
        guard let preview = profilePreview as? AcceptedBidProfilePreview else {
            return
        }
        preview.contactInfoView.email = user.email
        preview.contactInfoView.phoneNumber = user.phoneNumber
    }
}
