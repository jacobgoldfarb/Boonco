//
//  ProfileViewController.swift
//  
//
//  Created by Peter Huang on 2020-03-26.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    let navigationTitle = "Profile"
    
    var profileView = ProfileView()
    var viewModel: ProfileViewModel!
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProfileViewModel(delegate: self)
        setupController()
        setupTableViewConnections()
        profileView.populate(for: viewModel.activeUser)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileView.populate(for: viewModel.activeUser)
        viewModel.fetchUserRentals()
        viewModel.fetchUserRequests()
        viewModel.fetchProfilePicture()
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillLayoutSubviews() {
        profileView.itemsTableView.updateCellSeparatorLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        profileView.itemsTableView.updateCellSeparatorLayout(isExiting: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadUserAssets()
    }
    
    private func setupController() {
        setupActions()
        setupContainerActions()
    }
    
    //MARK: Profile View Actions
    
    private func setupActions() {
        tapSegmentedControlElement()
        tapSettingsButton()
        tapEditProfileButton()
        tapWalletButton()
    }
    
    private func tapSegmentedControlElement() {
        profileView.segmentedControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
    }
    
    private func tapSettingsButton() {
        profileView.settingsButton.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
    }
    
    private func tapEditProfileButton() {
        profileView.editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
    }
    
    private func tapWalletButton() {
        profileView.walletButton.addTarget(self, action: #selector(didTapWalletButton), for: .touchUpInside)
    }
    
    //MARK: Profile View IBAction Events
    
    @objc private func handleSegmentChange(_ sender: SegmentedControl) {
        let index = sender.selectedSegmentIndex
        sender.changeUnderlinePosition()
        viewModel.currentSegmentView = profileView.segmentList[index]
        profileView.actionButton.setTitle(profileView.segmentList[index].buttonDescription, for: .normal)
        profileView.itemsTableView.reloadData()
        profileView.itemsTableView.updateView()
        profileView.itemsTableView.updateCellSeparatorLayout()
    }
    
    @objc private func didTapSettingsButton(_ sender: UIButton) {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    @objc private func didTapEditProfileButton(_ sender: UIButton) {
        let editProfileVC = EditProfileViewController()
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    @objc private func didTapWalletButton(_ sender: UIButton) {
        let walletVC = WalletViewController()
        navigationController?.pushViewController(walletVC, animated: true)
    }
    
    //MARK: Container Actions
    
    private func setupContainerActions() {
        tapActionButton()
    }
    
    private func tapActionButton() {
        profileView.actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
    }
    
    @objc private func didTapActionButton(_ sender: UIButton) {}
}

extension ProfileViewController: ProfileViewModelDelegate {
    func didGetRentals() {
        profileView.itemsTableView.reloadData()
    }
    
    func didGetRequests() {
        profileView.itemsTableView.reloadData()
    }
    
    func didUpdateProfilePicture(forUser user: User) {
        profileView.profilePhotoImageView.image = user.profilePicture
    }
    
    func didUpdateProfile(forUser user: User) {
        profileView.nameLabel.text = "\(user.firstName) \(user.lastName)"
        profileView.locationLabel.text = user.address.city
    }
    
    func didDownloadProfilePicture(_ image: UIImage) {
        profileView.profilePhotoImageView.image = image
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableViewConnections() {
        profileView.itemsTableView.dataSource = self
        profileView.itemsTableView.delegate = self
        profileView.itemsTableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "myListingsCell")
    }
    
    //MARK: Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let itemModel: Item?
        switch viewModel.currentSegmentView {
        case .listings:
            itemModel = viewModel.myFilteredListings?[indexPath.row]
        case .requests:
            itemModel = viewModel.myFilteredRequests?[indexPath.row]
        default:
            itemModel = viewModel.myFilteredTransactions?[indexPath.row]
        }
        
        if let itemModel = itemModel {
            let detailVC = MyListingItemDetailViewController()
            detailVC.viewModel = ItemDetailViewModel(model: itemModel)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    //MARK: Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowTotal = 0
        switch viewModel.currentSegmentView {
        case .listings:
            rowTotal = viewModel.myFilteredListings?.count ?? 0
        case .requests:
            rowTotal = viewModel.myFilteredRequests?.count ?? 0
        default:
            rowTotal = viewModel.myFilteredTransactions?.count ?? 0
        }
        return rowTotal
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myListingsCell") as! ItemTableViewCell
        let model: Item?
        switch viewModel.currentSegmentView {
        case .listings:
            model = viewModel.myFilteredListings?[indexPath.row]
        case .requests:
            model = viewModel.myFilteredRequests?[indexPath.row]
        default:
            model = viewModel.myFilteredTransactions?[indexPath.row]//create a History or a completed transaction object
        }
        
        if let model = model {
            cell.itemName = model.title
            cell.duration = model.timeframe
            cell.associatedUserName = model.owner.name
            cell.price = model.price
            cell.distance = model.distance
            cell.thumbnailView.sd_setImage(with: model.thumbnailURL, completed: nil)
        }
        return cell
    }
}
