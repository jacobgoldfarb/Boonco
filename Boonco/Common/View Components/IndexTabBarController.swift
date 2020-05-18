//
//  IndexTabBarController.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-26.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class IndexTabBarController: UITabBarController {
    
    lazy var authenticatedControllers: [UIViewController] = {
        let profileVC = ProfileViewController()
        let rentVC = BorrowViewController()
        let lendVC = LendViewController()
        let activityVC = ActivityViewController()
        
        profileVC.title = "Profile"
        profileVC.tabBarItem.image = Theme.standard.images.getProfileIcon()
        rentVC.title = "Borrow"
        rentVC.tabBarItem.image = Theme.standard.images.getBorrowIcon()
        lendVC.title = "Lend"
        lendVC.tabBarItem.image = Theme.standard.images.getLendIcon()
        activityVC.title = "Activity"
        activityVC.tabBarItem.image = Theme.standard.images.getActivityIcon()
        
        return [
            UINavigationController(rootViewController: rentVC),
            UINavigationController(rootViewController: lendVC),
            UINavigationController(rootViewController: activityVC),
            UINavigationController(rootViewController: profileVC)
        ]
    }()
    
    lazy var unauthenticatedControllers: [UIViewController] = {
        let redirectVC = RedirectDummyViewController()
        let rentVC = BorrowViewController()
        let lendVC = LendViewController()
        
        redirectVC.title = "Profile"
        redirectVC.tabBarItem.image = Theme.standard.images.getProfileIcon()
        rentVC.title = "Borrow"
        rentVC.tabBarItem.image = Theme.standard.images.getBorrowIcon()
        lendVC.title = "Lend"
        lendVC.tabBarItem.image = Theme.standard.images.getLendIcon()
        
        return [
            UINavigationController(rootViewController: rentVC),
            UINavigationController(rootViewController: lendVC),
            UINavigationController(rootViewController: redirectVC)
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AuthState.shared.delegate = self
        AuthState.shared.checkAuth()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        viewControllers = unauthenticatedControllers
    }
}

extension IndexTabBarController: AuthStateDelegate {
    func didSetUser(_ user: User) {
        viewControllers = authenticatedControllers
    }
    
    func deauthorizeUser() {
        self.navigationController?.popViewController(animated: true)
    }
}

class RedirectDummyViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
        super.viewWillAppear(animated)
        tabBarController?.navigationController?.popToRootViewController(animated: true)
    }
}
