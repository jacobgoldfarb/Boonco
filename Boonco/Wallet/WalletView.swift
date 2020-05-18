//
//  WalletView.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-04.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class WalletView: UIView {
    //MARK: UIElements and Constants
    
    var currentBalance: Label!
    var addFundsButton: PrimaryButton!
    var autoReloadButton: SecondaryButton!
    var paymentMethodsTableView: UITableView!
    
    let addFundsButtonTitle = "Add Funds"
    let autoReloadButtonTitle = "Auto Reload"
    let paymentMethodsTitle = "Payment Methods"
    let viewBackgroundColor = UIColor.white
    
    let componentsList: [String] = ["Apple Pay", "Credit Card", "Add Payment Method", "Personal"]
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
        currentBalance = Label()
        addFundsButton = PrimaryButton()
        autoReloadButton = SecondaryButton()
        paymentMethodsTableView = UITableView(frame: .zero, style: .plain)
    }
    
    private func setupSubviews() {
        setupCurrentBalanceLabel(currentBalance)
        setupAddFundsButton(addFundsButton, title: addFundsButtonTitle)
        setupAutoReloadButton(autoReloadButton, title: autoReloadButtonTitle)
        setupPaymentMethodsTableView(paymentMethodsTableView)
    }
    
    private func setupCurrentBalanceLabel(_ label: Label) {
        let currentBalance = 1502 //this will be linked from the view model
        let balanceText = Utilities.formatNumber(withCommas: currentBalance)
        label.text = "Pocket Butler Cash: \(balanceText)"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25)
        addSubview(label)
    }
    
    private func setupAddFundsButton(_ button: PrimaryButton, title: String) {
        button.setTitle(title, for: .normal)
        addSubview(button)
    }
    
    private func setupAutoReloadButton(_ button: SecondaryButton, title: String) {
        button.setTitle(title, for:.normal)
        addSubview(button)
    }
    
    private func setupPaymentMethodsTableView(_ table: UITableView) {
        table.backgroundColor = viewBackgroundColor
        addSubview(table)
    }
}

//MARK: Constraints

extension WalletView {
    private func setupConstraints() {
        setupConstraintsForCurrentBalance(currentBalance)
        setupConstraintsForAddFundsButton(addFundsButton)
        setupConstraintsForAutoReloadButton(autoReloadButton)
        setupConstraintsForPaymentMethodsTableView(paymentMethodsTableView)
    }
    
    private func setupConstraintsForCurrentBalance(_ label: Label) {
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
            make.leading.trailing.equalToSuperview().inset(18)
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).inset(30)
        }
    }
    
    private func setupConstraintsForAddFundsButton(_ button: UIButton) {
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview().inset(18)
            make.top.equalTo(currentBalance.snp.bottom).offset(20)
        }
    }
    
    private func setupConstraintsForAutoReloadButton(_ button: UIButton) {
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview().inset(18)
            make.top.equalTo(addFundsButton.snp.bottom).offset(20)
        }
    }
    
    private func setupConstraintsForPaymentMethodsTableView(_ table: UITableView) {
        let totalComponentsHeight = componentsHeight * (componentsList.count + 1)
        
        table.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(autoReloadButton.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(totalComponentsHeight)
        }
    }
}
