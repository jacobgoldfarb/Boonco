//
//  ActivityViewController.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-02.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
    
    var viewModel: ActivityViewModel!
    let activityView = ActivityView()
    var activeSegment: ActivitySegment! {
        didSet {
            remakeView(for: activeSegment.rawValue)
        }
    }
        
    override func loadView() {
        view = activityView
        activityView.listingsHeaderText = "Active Listings"
        activityView.requestsHeaderText = "Active Requests"
        activityView.segmentControl.addTarget(self, action: #selector(didTapSegmentControlButton(_:)), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ActivityViewModel(delegate: self)
        setupNavigationBar()
        activeSegment = .market
        viewModel.fetchBids()
        setupTableView(activityView.requestsTableView)
        setupTableView(activityView.listingsTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchBids()
        navigationController?.navigationBar.isTranslucent = false
        activityView.updateBothTableViews()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.clipsToBounds = false
        navigationController?.navigationBar.barTintColor = Theme.standard.colors.primary
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,
                                                                   .font: Theme.standard.font.header]
    }
    
    private func setupTableView(_ tableView: TableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "myListingsCell")
        tableView.register(BiddedMarketItemTableViewCell.self, forCellReuseIdentifier: "marketCell")
    }
    
    
    @objc private func didTapSegmentControlButton(_ sender: SegmentedControl) {
        let segmentedControl = activityView.segmentControl
        activeSegment = ActivitySegment(rawValue: sender.selectedSegmentIndex)
        segmentedControl.changeUnderlinePosition()
        activityView.requestsTableView.reloadData()
        activityView.listingsTableView.reloadData()
        activityView.updateBothTableViews()
    }
    
    private func remakeView(for index: Int) {
        if index == ActivitySegment.market.rawValue {
            setupViewForMarket()
        } else if index == ActivitySegment.posts.rawValue {
            setupViewForPosts()
        }
    }
    
    private func setupViewForPosts() {
        activityView.listingsHeaderText = "My Listing Responses"
        activityView.requestsHeaderText = "My Request Responses"
    }
    
    private func setupViewForMarket() {
        activityView.listingsHeaderText = "Bidded on Listings"
        activityView.requestsHeaderText = "Bidded on Requests"
    }
}

extension ActivityViewController: ActivityViewModelDelegate {
    func didFetchBids() {
        activityView.requestsTableView.reloadData()
        activityView.listingsTableView.reloadData()
        activityView.updateBothTableViews()
    }
}
