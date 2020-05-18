//
//  EditProfileDetailViewController.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-09.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class EditProfileDetailViewController: UIViewController, ProfileEditorModelDelegate {
    var profileType: EditableProfileDetail = .edit
    let navigationTitle: String = "Edit Profile Details"
    var originalTranslucency: Bool = true
    
    var editProfileDetailView = EditProfileDetailView()
    var viewModel: ProfileEditorViewModel!
    
    init(as profileType: EditableProfileDetail) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = ProfileEditorViewModel(delegate: self)
        self.profileType = profileType
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.viewModel = ProfileEditorViewModel(delegate: self)
    }
    
    override func loadView() {
        editProfileDetailView = EditProfileDetailView(of: profileType)
        view = editProfileDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK: Navigation
    
    func setupNavigation() {
        setupLeftBarButton()
    }
    
    func setupLeftBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(didTapGoBack))
    }
    
    //MARK: Actions
    
    private func setupController() {
        setupActions()
    }
    
    private func setupActions() {
        tapUpdateButton()
    }
    
    private func tapUpdateButton() {
        editProfileDetailView.updateDetailButton.addTarget(self, action: #selector(didTapUpdateButton), for: .touchUpInside)
    }
    
    private func tapNavigationPrevious() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: IBAction Events
    
    @objc private func didTapUpdateButton(_ sender: SecondaryButton) {
        print("Update button tapped")
        
        guard let updatedField = editProfileDetailView.detailTextField.text, updatedField != "" else {
            editProfileDetailView.errorLabel.text = "Field is empty or invalid!"
            return
        }
        updateField(with: updatedField)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapGoBack(_ sender: UIBarButtonItem) {
        tapNavigationPrevious()
    }
    
    //MARK: Intermediate functions
    
    private func updateField(with contents: String) {
        switch profileType {
        case .firstName:
            viewModel.changeFirstName(to: contents)
        case .lastName:
            viewModel.changeLastName(to: contents)
        case .phoneNumber:
            viewModel.changePhoneNumber(to: contents)
        case .password:
            return
        case .location:
            viewModel.changeLocation(to: contents)
        case .edit:
            return
        }
    }
    
    //MARK: Profile Editor Model Delegate
    
    func didUpdateProfileData() {
        let user = viewModel.activeUser
        
        switch profileType {
        case .firstName:
            editProfileDetailView.detailTextField.text = user.firstName
        case .lastName:
            editProfileDetailView.detailTextField.text = user.lastName
        case .phoneNumber:
            editProfileDetailView.detailTextField.text = user.phoneNumber
        case .password:
            return
        case .location:
            editProfileDetailView.detailTextField.text = user.address.city
        case .edit:
            return
        }
    }
}
