//
//  ViewController.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-25.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var signUpView: SignUpView!
    var viewModel: SignUpViewModel!
    
    override func loadView() {
        signUpView = SignUpView(frame: UIScreen.main.bounds)
        view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupViewModel()
        if let currentLocation = LocationManager.shared.lastLocation {
            viewModel.syncAndUpdateAddress(from: currentLocation)
        }
    }
    
    private func setupViewModel() {
        viewModel = SignUpViewModel(authService: AuthenticationService())
        viewModel.signUpDelegate = self
    }
    
    private func setupController() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupActions()
        setupTableViewConnections()
    }
    
    private func setupActions() {
        setupActionsForSwitchToLoginButton()
        setupActionsForSignUpButton()
    }
    
    private func setupActionsForSignUpButton() {
        signUpView.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    private func setupActionsForSwitchToLoginButton() {
        signUpView.switchToLogInButton.addTarget(self, action: #selector(didTapSwitchToLogIn), for: .touchUpInside)
    }
    
    //MARK: Navigation
    
    @objc private func didTapSwitchToLogIn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapSignUp(_ sender: UIButton) {
        ProgressView.show()
        viewModel!.signUp()
    }
}

// MARK: View Model Delegate

extension SignUpViewController: SignUpViewModelDelegate {
    func signUpDidSucceed() {
        ProgressView.dismiss()
        navigationController?.pushViewController(IndexTabBarController(), animated: true)
    }
    
    func signUpDidFail(withError error: Error) {
        ProgressView.dismiss()
        if let error = error as? LRError {
            signUpView.errorMessageLabel.text = error.description
        }
    }
    
    func didUpdateAddress(_ address: String) {
        let locationCellRow = self.signUpView.signUpFields.firstIndex(of: .location) ?? 2
        let indexPath = IndexPath(row: locationCellRow, section: 0)
        if let cell = self.signUpView.signUpTableview.cellForRow(at: indexPath) as? EntranceViewTableViewCell {
            cell.textField.text = address
            viewModel.signUpCredentials.location = address
        }
    }
}

//MARK: Table view data source and delegate

extension SignUpViewController: UITableViewDataSource, UITableViewDelegate {
    private func setupTableViewConnections() {
        signUpView.signUpTableview.dataSource = self
        signUpView.signUpTableview.delegate = self
        signUpView.signUpTableview.register(EntranceViewTableViewCell.self, forCellReuseIdentifier: "SignUpTableViewCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return signUpView.signUpFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignUpTableViewCell") as! EntranceViewTableViewCell
        cell.delegate = self
        let entryField: SignUpRequiredFields = signUpView.signUpFields[indexPath.row]
        cell.descriptionLabel.text = entryField.description
        cell.textField.placeholder = entryField.placeholder
        
        switch entryField {
        case .firstName:
            cell.textField.autocorrectionType = .no
        case .lastName:
            cell.textField.autocorrectionType = .no
        case .location:
            cell.textField.autocorrectionType = .no
            cell.textField.adjustsFontSizeToFitWidth = true
        case .email:
            cell.textField.autocapitalizationType = .none
            cell.textField.keyboardType = .emailAddress
        case .password:
            cell.textField.isSecureTextEntry = true
        case .confirmPassword:
            cell.textField.isSecureTextEntry = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

//MARK: Table view cell delegate

extension SignUpViewController: EntranceViewTableViewCellDelegate {
    
    func textField(editingDidBeginIn cell: EntranceViewTableViewCell) {}
    
    func textField(editingChangedInTextField newText: String, in cell: EntranceViewTableViewCell) {
        if let indexPath = signUpView.signUpTableview.indexPath(for: cell) {
            
            let entryField: SignUpRequiredFields = signUpView.signUpFields[indexPath.row]
            
            switch entryField {
            case .firstName:
                viewModel.signUpCredentials.firstName = newText
            case .lastName:
                viewModel.signUpCredentials.lastName = newText
            case .location:
                viewModel.signUpCredentials.location = newText
                viewModel.generateUserLocation(from: newText)
            case .email:
                viewModel.signUpCredentials.email = newText
            case .password:
                viewModel.signUpCredentials.password = newText
            case .confirmPassword:
                viewModel.signUpCredentials.confirmPassword = newText
            }
        }
    }
}
