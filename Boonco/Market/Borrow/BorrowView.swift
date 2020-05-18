//
//  BorrowView.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-31.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class BorrowView: UIView {
    
    //MARK: UIElements and Constants
    
    var createItemButton: UIButton!
    var activeRentalsTableView: TableView!
    var scrollView: UIScrollView = UIScrollView()
    let refreshControl: UIRefreshControl = UIRefreshControl()
    let categoriesView: CategoriesPreview = CategoriesPreview()
    
    private var tableViewHeaderLabel: Label!
    private let createOfferingButtonTitle = "Create a Listing"
    private let tableViewHeader = "Find Near You"
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
    
    func updateView() {
        scrollView.contentSize = CGSize(width: frame.width, height: frame.height + categoriesView.frame.height)
        categoriesView.collectionView.flashScrollIndicators()
    }
    
    private func setupView() {
        backgroundColor = .white
        initiateSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    //MARK: Setup subviews
    
    func setupSubviews() {
        setupCreateItemButton()
        setupTableView()
        setupTableViewHeader()
        setupScrollView()
        scrollView.addSubviews(activeRentalsTableView, createItemButton, tableViewHeaderLabel, categoriesView)
        addSubview(scrollView)
    }
    
    private func initiateSubviews() {
        createItemButton = SecondaryButton()
        activeRentalsTableView = TableView()
        tableViewHeaderLabel = Label()
    }
    
    private func setupCreateItemButton() {
        createItemButton.setTitle(createOfferingButtonTitle, for: .normal)
    }
    
    private func setupScrollView() {
        scrollView.decelerationRate = .fast
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private func setupTableView() {
        activeRentalsTableView.emptyIcon = Theme.standard.images.getFolderEmptyGrey()
        activeRentalsTableView.emptyText = emptyTableViewPrompt
        activeRentalsTableView.updateView()
        scrollView.refreshControl = refreshControl
    }
    
    private func setupTableViewHeader() {
        tableViewHeaderLabel.text = tableViewHeader
        tableViewHeaderLabel.font = Theme.standard.font.largeHeader
    }
}

// MARK: Constraints

extension BorrowView {
    func setupConstraints() {
        setupConstraintsForScrollView()
        setupConstraintsForCreateItemButton()
        setupConstraintsForCategoriesView()
        setupConstraintsForTableViewHeader()
        setupConstraintsForTableView()
    }
    
    private func setupConstraintsForCreateItemButton() {
        createItemButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.width.equalToSuperview().inset(50)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupConstraintsForCategoriesView() {
        categoriesView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(createItemButton.snp.bottom).offset(25)
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3.8)
        }
    }
    
    private func setupConstraintsForTableViewHeader() {
        tableViewHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(categoriesView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func setupConstraintsForTableView() {
        activeRentalsTableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tableViewHeaderLabel.snp.bottom).offset(15)
            make.width.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin)
        }
    }
    
    private func setupConstraintsForScrollView() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
