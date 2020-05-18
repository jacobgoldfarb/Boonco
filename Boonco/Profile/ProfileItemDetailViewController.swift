//
//  ProfileItemDetailViewController.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-05.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class ProfileItemDetailViewController: ItemDetailViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewDidDisappear(animated)
    }
}

class MyListingItemDetailViewController: ProfileItemDetailViewController {}

class MyRequestItemDetailViewController: ProfileItemDetailViewController {}
