//
//  SettingsView.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-03.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class SettingsView: UIView {

    //MARK: UIElements and Constants
    
    var logoutButton: SecondaryButton!
    var tableView: UITableView!
    
    let logoutButtonTitle = "Log Out"
    let viewBackgroundColor = UIColor.white
    
    // Removed temporarily for app completeness
//    let componentsList: [String] = ["Notifications", "Privacy", "Security", "Account", "Help", "About", "Licenses"]
    let componentsList: [String] = ["Help"]
    let componentsHeight = 42

    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //MARK: Setup view
    
    private func setupView() {
        backgroundColor = viewBackgroundColor
        initiateSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: Subview Setup
    
    private func initiateSubviews() {
        logoutButton = SecondaryButton()
        tableView = UITableView(frame: .zero, style: .plain)
    }
    
    private func setupSubviews() {
        setupLogoutButton(logoutButton, title: logoutButtonTitle)
        setupTableView(tableView)
    }
    
    private func setupLogoutButton(_ button: SecondaryButton, title: String) {
        button.setTitle(title, for: .normal)
        addSubview(button)
    }
    
    private func setupTableView(_ table: UITableView) {
        table.backgroundColor = viewBackgroundColor
        addSubview(table)
    }
}

//MARK: Constraints

extension SettingsView {
    private func setupConstraints() {
        setupConstraintsForTableView(tableView)
        setupConstraintsForLogoutButton(logoutButton)
    }
    
    private func setupConstraintsForTableView(_ table: UITableView) {
        let totalComponentsHeight = componentsHeight * componentsList.count
        
        table.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).inset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(totalComponentsHeight)
        }
    }
    
    private func setupConstraintsForLogoutButton(_ button: UIButton) {
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview().inset(18)
            make.top.equalTo(tableView.snp.bottom).offset(20)
        }
    }
}
