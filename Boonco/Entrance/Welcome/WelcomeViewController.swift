//
//  WelcomeViewController.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-23.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var welcomeView: WelcomeView!
    
    override func loadView() {
        welcomeView = WelcomeView(frame: UIScreen.main.bounds)
        view = welcomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillAppear(animated)
        if !AuthState.shared.agreedToTOS() {
            presentTOS()
        }
    }
    
    //MARK: Actions
    
    private func setupActions() {
        tapSignUpButton()
        tapLogInButton()
        tapSkipButton()
    }
    
    private func tapSignUpButton() {
        welcomeView.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    private func tapLogInButton() {
        welcomeView.logInButton.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
    }
    
    private func tapSkipButton() {
        welcomeView.skipButton.addTarget(self, action: #selector(didTapSkip), for: .touchUpInside)
    }
    
    // MARK: Navigation
    
    @objc private func didTapSignUp(_ sender: UIButton) {
        guard AuthState.shared.agreedToTOS() else {
            presentTOS()
            return
        }
        navigationController?.pushViewController(LogInViewController(), animated: false)
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    @objc private func didTapLogIn(_ sender: UIButton) {
        guard AuthState.shared.agreedToTOS() else {
            presentTOS()
            return
        }
        navigationController?.pushViewController(LogInViewController(), animated: true)
    }
    
    @objc private func didTapSkip(_ sender: UIButton) {
        guard AuthState.shared.agreedToTOS() else {
            presentTOS()
            return
        }
        navigationController?.pushViewController(IndexTabBarController(), animated: true)
    }
    
    private func presentTOS() {
        let tosVC = UINavigationController(rootViewController: TOSViewController())
        present(tosVC, animated: true)
    }
}

