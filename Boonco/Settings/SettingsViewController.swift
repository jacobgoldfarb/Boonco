//
//  SettingsViewController.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-03.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let navigationTitle: String = "Settings"
    var originalBackgroundColor: UIColor = .white
    var originalTranslucency: Bool = true
    
    var viewModel: SettingsViewModel!
    var settingsView = SettingsView()
    
    override func loadView() {
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SettingsViewModel()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        cleanupNavigationBar()
        super.viewDidDisappear(animated)
    }
    
    private func setupController() {
        setupActions()
        setupTableViewConnections()
    }
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        originalTranslucency = navigationController?.navigationBar.isTranslucent ?? true
        originalBackgroundColor = navigationController?.navigationBar.barTintColor ?? UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.clipsToBounds = false
        navigationController?.navigationBar.barTintColor = settingsView.viewBackgroundColor
        navigationController?.navigationBar.topItem?.title = navigationTitle
    }
    
    private func cleanupNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.navigationBar.barTintColor = originalBackgroundColor
        navigationController?.navigationBar.isTranslucent = originalTranslucency
    }
    
    //MARK: Settings View Actions
    
    private func setupActions() {
        tapLogoutButton()
    }
    
    private func tapLogoutButton() {
        settingsView.logoutButton.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
    }
    
    //MARK: Settings View IBAction Events
    
    @objc private func didTapLogoutButton(_ sender: UIButton) {
        viewModel.logOut()
        tabBarController?.navigationController?.popToRootViewController(animated: true)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableViewConnections() {
        settingsView.tableView.dataSource = self
        settingsView.tableView.delegate = self
    }
    
    //MARK: Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if settingsView.componentsList[indexPath.row] == "Help" {
            let alertVC = MessageAlertController()
            alertVC.title = "Need Help?"
            alertVC.message = "Email the creators at boonco.owner@gmail.com"
            present(alertVC, animated: true)
        }
        print("TESTING: This will expand into the details of \(settingsView.componentsList[indexPath.row]).")
    }
    
    //MARK: Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsView.componentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = settingsView.componentsList[indexPath.row]
        cell.textLabel?.font = Theme.standard.font.regular
        cell.backgroundColor = settingsView.viewBackgroundColor
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(settingsView.componentsHeight)
    }
}
