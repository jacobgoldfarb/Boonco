//
//  ViewController.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-25.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit
import SnapKit

class LogInViewController: UIViewController {
    
    var logInView: LoginView!
    var viewModel: LoginViewModel?
    
    override func loadView() {
        logInView = LoginView(frame: UIScreen.main.bounds)
        view = logInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillAppear(animated)
        setupViewModel()
    }
    
   override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupViewModel()
    }
    
    private func setupViewModel() {
            viewModel = LoginViewModel(authService: AuthenticationService())
            viewModel?.delegate = self
    }
    
    private func setupController() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupActions()
    }
    
    private func setupActions() {
        tapLogInButton()
        tapSwitchToSignUpButton()
        tapSkipButton()
    }
    
    private func tapLogInButton() {
        logInView.logInButton.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
    }
    
    private func tapSwitchToSignUpButton() {
        logInView.switchToSignUpButton.addTarget(self, action: #selector(didTapSwitchToSignUp), for: .touchUpInside)
    }
    
    private func tapSkipButton() {
        logInView.skipButton.addTarget(self, action: #selector(didTapSkip), for: .touchUpInside)
    }
    
    private func resetFields(withEmail: Bool) {
        if withEmail {
            logInView.emailTextField.text = ""
        }
        
        logInView.errorMessageLabel.text = ""
        logInView.passwordTextField.text = ""
    }
    
    // MARK: Navigation
    
    @objc private func didTapLogIn(_ sender: UIButton) {
        guard let email = logInView.emailTextField.text, !email.isEmpty,
            let password = logInView.passwordTextField.text, !password.isEmpty else {
                logInView.errorMessageLabel.text = "Please enter your email and password"
                return
        }
        do {
            ProgressView.show()
            try viewModel!.logIn(withEmail: email, password: password)
        } catch let error {
            logInView.errorMessageLabel.text = "Error: \(error)"
        }
    }
    
    @objc private func didTapSwitchToSignUp(_ sender: UIButton) {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    @objc private func didTapSkip(_ sender: UIButton) {
        navigationController?.pushViewController(IndexTabBarController(), animated: true)
    }
}

extension LogInViewController: LogInViewModelDelegate {
    func logInDidSucceed() {
        ProgressView.dismiss()
        resetFields(withEmail: false)
        navigationController?.pushViewController(IndexTabBarController(), animated: true)
    }
    
    func logInDidFail(withError error: Error) {
        logInView.errorMessageLabel.text = "Invalid email or password"
        ProgressView.dismiss()
    }
}

