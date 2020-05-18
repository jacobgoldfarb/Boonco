//
//  CategoryView.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-21.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class BorrowByCategoryView: UIView {
    
    //MARK: UIElements and Constants
    
    var categoryFilteredRentalsTableView: TableView!
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    private var tableViewHeaderLabel: Label!
    var tableViewHeader = "" {
        didSet {
            tableViewHeaderLabel.text = tableViewHeader
        }
    }
    private let emptyTableViewPrompt = "Looks like there are no open listings at the moment."
    
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
    
    //MARK: Setup subviews
    
    func setupSubviews() {
        setupTableView()
        setupTableViewHeader()
        addSubviews(categoryFilteredRentalsTableView, tableViewHeaderLabel)
    }
    
    private func initiateSubviews() {
        categoryFilteredRentalsTableView = TableView()
        tableViewHeaderLabel = Label()
    }
    
    private func setupTableView() {
        categoryFilteredRentalsTableView.emptyIcon = Theme.standard.images.getFolderEmptyGrey()
        categoryFilteredRentalsTableView.emptyText = emptyTableViewPrompt
        categoryFilteredRentalsTableView.updateView()
        categoryFilteredRentalsTableView.refreshControl = refreshControl
    }
    
    private func setupTableViewHeader() {
        tableViewHeaderLabel.text = tableViewHeader
        tableViewHeaderLabel.font = Theme.standard.font.largeHeader
    }
}

// MARK: Constraints

extension BorrowByCategoryView {
    func setupConstraints() {
        setupConstraintsForTableViewHeader()
        setupConstraintsForTableView()
    }
    
    private func setupConstraintsForTableViewHeader() {
        tableViewHeaderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func setupConstraintsForTableView() {
        categoryFilteredRentalsTableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tableViewHeaderLabel.snp.bottom).offset(15)
            make.width.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin)
        }
    }
}
