//
//  ActivityView.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-02.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

enum ActivitySegment: Int {
    case market = 0
    case posts = 1
}

extension ActivitySegment:  CaseIterable, CustomStringConvertible {
    var description: String {
        switch self {
        case .market:
            return "Market"
        case .posts:
            return "My Posts"
        }
    }
}

class ActivityView: UIView {
    
    //MARK: Constants and UIElements
    
    let scrollView: UIScrollView = UIScrollView()
    let contentView: UIView = UIView()
    
    let segmentControl: SegmentedControl = SegmentedControl(items: ActivitySegment.allCases.map { $0.description } )
    let listingsTableView: TableView = TableView()
    let requestsTableView: TableView = TableView()
    private let listingsHeaderLabel: Label = Label()
    private let requestsHeaderLabel: Label = Label()
    
    let peekComponentHeight: CGFloat = 30
    private let emptyTableViewPromptListings = "Looks like there are no listings at the moment."
    private let emptyTableViewPromptRequests = "Looks like there are no requests at the moment."
    
    var listingsHeaderText: String = "" {
        didSet {
            listingsHeaderLabel.text = listingsHeaderText
        }
    }
    var requestsHeaderText: String = "" {
        didSet {
            requestsHeaderLabel.text = requestsHeaderText
        }
    }
    
    //MARK: Initialization
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup view
    
    private func setupView() {
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    //MARK: Setup subviews
    
    private func setupSubviews() {
        setupScrollView(scrollView, contentView)
        setupSegmentedControl(segmentControl)
        setupLabel(listingsHeaderLabel, isTopLabel: true)
        setupLabel(requestsHeaderLabel, isTopLabel: false)
        setupTableView(listingsTableView, with: 0)
        setupTableView(requestsTableView, with: 1)
    }
    
    private func setupScrollView(_ scrollView: UIScrollView, _ contentView: UIView) {
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.bounces = false
        scrollView.addSubview(contentView)
        addSubview(scrollView)
    }
    
    private func setupSegmentedControl(_ segmentedControl: SegmentedControl) {
        segmentControl.selectedSegmentIndex = 0
        addSubview(segmentedControl)
    }
    
    private func setupLabel(_ label: Label, isTopLabel: Bool) {
        label.font = Theme.standard.font.largeHeader        
        if isTopLabel {
            addSubview(label)
        } else {
            contentView.addSubview(label)
        }
    }
    
    private func setupDropShadow(_ label: Label) {
        label.layer.shadowRadius = 2.0
        label.layer.shadowOpacity = 0.2
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        label.layer.masksToBounds = false
    }
    
    private func setupTableView(_ tableview: TableView, with tag: Int) {
        tableview.tag = tag
        tableview.emptyIcon = Theme.standard.images.getFolderEmptyGrey()
        tableview.emptyText = (tag == 0) ? emptyTableViewPromptListings : emptyTableViewPromptRequests
        tableview.updateView()
        contentView.addSubview(tableview)
    }
    
    func updateBothTableViews() {
        requestsTableView.updateView()
        listingsTableView.updateView()
    }
}

//MARK: Constraints

extension ActivityView {
    func setupConstraints() {
        setupConstraintsForScrollView()
        setupConstraintsForSegmentController()
        setupConstraintsForListingsHeaderLabel()
        setupConstraintsForRequestHeaderLabel()
        setupConstraintsForListingsTableView()
        setupConstraintsForRequestsTableView()
    }
    
    private func setupConstraintsForSegmentController() {
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(layoutMarginsGuide.snp.top)
            make.width.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
    }

    private func setupConstraintsForListingsHeaderLabel() {
        listingsHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func setupConstraintsForScrollView() {
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(listingsHeaderLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(layoutMarginsGuide.snp.bottomMargin)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(710) //tableviews + 50
        }
    }
    
    private func setupConstraintsForListingsTableView() {
        listingsTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(contentView.snp.top)
            make.height.equalTo(330)
        }
    }
    
    private func setupConstraintsForRequestHeaderLabel() {
        requestsHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(listingsTableView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func setupConstraintsForRequestsTableView() {
        requestsTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(requestsHeaderLabel.snp.bottom)
            make.height.equalTo(330)
        }
    }
}
