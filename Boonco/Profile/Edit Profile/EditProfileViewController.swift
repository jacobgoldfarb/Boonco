//
//  EditProfileViewController.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-04.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    let navigationTitle: String = "Edit Profile"
    var originalBackgroundColor: UIColor = .white
    var originalTranslucency: Bool = true
    var animateNavigation = true
    
    var editProfileView = EditProfileView()
    
    override func loadView() {
        view = editProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(animateNavigation)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        cleanupNavigationBar()
        super.viewDidDisappear(animated)
    }
    
    private func setupController() {
        setupActions()
        setupTableViewConnections()
    }
    
    private func setupNavigationBar(_ animated: Bool = true) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        originalTranslucency = navigationController?.navigationBar.isTranslucent ?? true
        originalBackgroundColor = navigationController?.navigationBar.barTintColor ?? UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.clipsToBounds = false
        navigationController?.navigationBar.barTintColor = editProfileView.viewBackgroundColor
        navigationController?.navigationBar.topItem?.title = navigationTitle
        animateNavigation = false
    }
    
    private func cleanupNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.navigationBar.barTintColor = originalBackgroundColor
        navigationController?.navigationBar.isTranslucent = originalTranslucency
    }
    
    //MARK: Edit Profile View Actions
    
    private func setupActions() {
        tapButton()
    }
    
    private func tapButton() {
        editProfileView.editProfilePictureButton.addTarget(self, action: #selector(didTapUploadPictureButton), for: .touchUpInside)
    }
    
    //MARK: Edit Profile View IBAction Events
    
    @objc private func didTapUploadPictureButton(_ sender: UIButton) {
        print("Upload picture button tapped")
        let uploadVC = UINavigationController(rootViewController: ProfilePictureViewController())
        uploadVC.modalPresentationStyle = .popover
        navigationController?.present(uploadVC, animated: true, completion: nil)
    }
    
    @objc private func didTapLogoutButton(_ sender: UIButton) {
        print("Log out button tapped")
        navigationController?.popToRootViewController(animated: true)
    }
}

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableViewConnections() {
        editProfileView.tableView.dataSource = self
        editProfileView.tableView.delegate = self
    }
    
    //MARK: Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("TESTING: This will expand into the details of \(editProfileView.componentsList[indexPath.row].description).")
        openEditScreen(of: editProfileView.componentsList[indexPath.row])
    }
    
    private func openEditScreen(of profileType: EditableProfileDetail) {
        let editDetailVC: UINavigationController
        
        switch profileType {
        case .firstName:
            editDetailVC = UINavigationController(rootViewController: EditFirstNameViewController())
        case .lastName:
            editDetailVC = UINavigationController(rootViewController: EditLastNameViewController())
        case .phoneNumber:
            editDetailVC = UINavigationController(rootViewController: EditPhoneNumberViewController())
        case .password:
            editDetailVC = UINavigationController(rootViewController: EditPasswordViewController())
        case .location:
            editDetailVC = UINavigationController(rootViewController: EditLocationViewController())
        default:
            editDetailVC = UINavigationController(rootViewController: EditProfileDetailViewController(as: .edit))
        }
        
        editDetailVC.modalPresentationStyle = .popover
        navigationController?.present(editDetailVC, animated: true, completion: nil)
    }
    
    //MARK: Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editProfileView.componentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = editProfileView.componentsList[indexPath.row].description
        cell.textLabel?.font = Theme.standard.font.regular
        cell.backgroundColor = editProfileView.viewBackgroundColor
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(editProfileView.componentsHeight)
    }
}
