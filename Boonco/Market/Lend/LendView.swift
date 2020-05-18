//
//  LendView.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-28.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class LendView: UIView {
    
    //MARK: UIElements and Constants
    
    var createOfferingButton: SecondaryButton!
    var activeRequestsTableView: TableView!
    private var tableViewHeaderLabel: Label!
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    private let createOfferingButtonTitle = "Create a Request"
    private let tableViewHeader = "Find Near You"
    private let emptyTableViewPrompt = "Looks like there are no open requests at the moment."
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup view
    
    private func setupView() {
        backgroundColor = .white
        initiateSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    //MARK: Setup Subviews
    
    private func setupSubviews() {
        setupCreateOfferingButton()
        setupTableView()
        setupTableViewHeader()
        addSubviews(createOfferingButton, activeRequestsTableView, tableViewHeaderLabel)
    }
    
    private func initiateSubviews() {
        createOfferingButton = SecondaryButton()
        activeRequestsTableView = TableView()
        tableViewHeaderLabel = Label()
    }
    
    private func setupCreateOfferingButton() {
        createOfferingButton.setTitle(createOfferingButtonTitle, for: .normal)
    }
    
    private func setupTableView() {
        activeRequestsTableView.emptyIcon = Theme.standard.images.getFolderEmptyGrey()
        activeRequestsTableView.emptyText = emptyTableViewPrompt
        activeRequestsTableView.refreshControl = refreshControl
        activeRequestsTableView.updateView()
    }
    
    private func setupTableViewHeader() {
        tableViewHeaderLabel.text = tableViewHeader
        tableViewHeaderLabel.font = Theme.standard.font.largeHeader
    }
}

//MARK: Constraints

extension LendView {
    private func setupConstraints() {
        setupConstraintsForCreateButton()
        setupConstraintsForTableViewHeader()
        setupConstraintsForTableView()
    }
    
    private func setupConstraintsForCreateButton() {
        createOfferingButton.snp.makeConstraints { make in
            make.top.equalTo(layoutMarginsGuide.snp.topMargin).offset(20)
            make.width.equalToSuperview().inset(50)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupConstraintsForTableViewHeader() {
        tableViewHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(createOfferingButton.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func setupConstraintsForTableView() {
        activeRequestsTableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tableViewHeaderLabel.snp.bottom).offset(15)
            make.width.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin)
        }
    }
}
