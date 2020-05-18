//
//  WalletViewController.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-04.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController {
    
    let navigationTitle: String = "Wallet"
    var originalBackgroundColor: UIColor = .white
    var originalTranslucency: Bool = true
    
    var walletView = WalletView()
    
    override func loadView() {
        view = walletView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        navigationController?.navigationBar.barTintColor = walletView.viewBackgroundColor
        navigationController?.navigationBar.topItem?.title = navigationTitle
    }
    
    private func cleanupNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.navigationBar.barTintColor = originalBackgroundColor
        navigationController?.navigationBar.isTranslucent = originalTranslucency
    }
    
    //MARK: Settings View Actions
    
    private func setupActions() {
        tapAddFundsButton()
        tapAutoReloadButton()
    }
    
    private func tapAddFundsButton() {
        walletView.addFundsButton.addTarget(self, action: #selector(didTapAddFundsButton), for: .touchUpInside)
    }
    
    private func tapAutoReloadButton() {
        walletView.autoReloadButton.addTarget(self, action: #selector(didTapAutoReloadButton), for: .touchUpInside)
    }
    
    //MARK: Settings View IBAction Events
    
    @objc private func didTapAddFundsButton(_ sender: UIButton) {
        print("Add funds button tapped")
    }
    
    @objc private func didTapAutoReloadButton(_ sender: UIButton) {
        print("Auto reload button tapped")
    }
}

extension WalletViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableViewConnections() {
        walletView.paymentMethodsTableView.dataSource = self
        walletView.paymentMethodsTableView.delegate = self
        //settingsView.tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "myListingsCell")
    }
    
    //MARK: Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("TESTING: This will expand into the details of \(walletView.componentsList[indexPath.row]).")
    }
    
    //MARK: Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return walletView.componentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = walletView.componentsList[indexPath.row]
        cell.textLabel?.font = Theme.standard.font.regular
        cell.backgroundColor = walletView.viewBackgroundColor
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(walletView.componentsHeight)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Payment Methods"
    }
}
