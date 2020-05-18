//
//  Font.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-27.
//  Copyright © 2020 Jacob Goldfarb. All rights reserved.
//

import UIKit

enum ControllerType {
    case login
    case signup
    case index
    case rentalItemDetail
    case categorySelector
    case profile
    case welcome
}

struct Theme {
    
    static var standard: Theme = Theme()
    
    let font = Font()
    let colors = Colors()
    let images = Images()
    let strings = Strings()
    let useBackend = true
    let debug = false
    
    let navBarStyle: [NSAttributedString.Key : Any] = [.font: Font().header,
                                                       .foregroundColor: Colors().primary]
    let rightBarButtonStyle: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: Font().regular]
    
    ///This variable refers to the entry view controller
    var activeControllerType: ControllerType = .welcome
    
    func getKeyController() -> UIViewController {
        switch activeControllerType {
        case .index:
            let loginVC = LogInViewController()
            let navVC = UINavigationController(rootViewController: loginVC)
            navVC.pushViewController(IndexTabBarController(), animated: true)
            return navVC
        case .welcome:
            return UINavigationController(rootViewController: WelcomeViewController())
        case .login:
            return UINavigationController(rootViewController: LogInViewController())
        case .signup:
            let navVC = UINavigationController(rootViewController: LogInViewController())
            navVC.viewControllers.append(SignUpViewController())
            return navVC
        case .rentalItemDetail:
            let tabVC = IndexTabBarController()
            tabVC.selectedIndex = 0
            (tabVC.viewControllers?[0] as! UINavigationController).pushViewController(ItemDetailViewController(), animated: false)
            return tabVC
        case .categorySelector:
            return UINavigationController(rootViewController: CategorySelectorViewController())
        case .profile:
            let tabVC = IndexTabBarController()
            tabVC.selectedIndex = 2
            return tabVC
        }
    }
}

