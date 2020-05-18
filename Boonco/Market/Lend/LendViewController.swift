//
//  LendViewController.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-28.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit
import SDWebImage

class LendViewController: UIViewController {
    
    var lendView: LendView!
    var viewModel: LendViewModel!
    lazy var searchBar = SearchBar(frame: CGRect.zero)
    var offeringFlowVC: UINavigationController {
        let offeringFlowVC = UINavigationController(rootViewController: RequestPhotosUploaderViewController())
        offeringFlowVC.modalPresentationStyle = .fullScreen
        return offeringFlowVC
    }
        
    override func loadView() {
        lendView = LendView(frame: CGRect.zero)
        lendView.createOfferingButton.addTarget(self, action: #selector(handleCreateOfferingTap), for: .touchUpInside)
        view = lendView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressView.show()
        setupTableView()
        setupNavigationBar()
        viewModel = LendViewModel(delegate: self)
        viewModel.fetchItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchItems()
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillLayoutSubviews() {
        lendView.activeRequestsTableView.updateCellSeparatorLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        lendView.activeRequestsTableView.updateCellSeparatorLayout(isExiting: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lendView.activeRequestsTableView.updateView()
    }
    
    private func setupTableView() {
        lendView.activeRequestsTableView.delegate = self
        lendView.activeRequestsTableView.dataSource = self
        lendView.activeRequestsTableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "myListingsCell")
        lendView.refreshControl.addTarget(self, action:  #selector(refreshTableView), for: .valueChanged)
    }
    
    //MARK: Navigation
    
    func setupNavigationBar() {
        setupSearchBar()
        navigationController?.navigationBar.clipsToBounds = false
        navigationController?.navigationBar.barTintColor = Theme.standard.colors.primary
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        navigationItem.hidesSearchBarWhenScrolling = true
        setupSearchBarCancel()
    }
    
    private func setupSearchBarCancel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
    }
    
    @objc private func handleCreateOfferingTap(_ sender: PrimaryButton) {
        guard AuthState.shared.getUser() != nil else {
            tabBarController?.navigationController?.popToRootViewController(animated: true)
            return
        }
        launchCreateOfferingFlow()
    }
    
    @objc private func refreshTableView() {
        viewModel.fetchItems()
    }
    
     private func launchCreateOfferingFlow() {
        navigationController?.present(offeringFlowVC, animated: true, completion: nil)
    }
}

// MARK: ViewModelDelegate

extension LendViewController: LendViewModelDelegate {
    func didFetchItems() {
        lendView.activeRequestsTableView.reloadData()
        lendView.refreshControl.endRefreshing()
        ProgressView.dismiss()
    }
    
    func failedFetchingItems() {
        lendView.refreshControl.endRefreshing()
        ProgressView.dismiss()
    }
}

// MARK: TableView

extension LendViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = RequestItemDetailViewController()
        let relevantModel = viewModel.filteredRequests[indexPath.row]
        detailVC.viewModel = ItemDetailViewModel(model: relevantModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension LendViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myListingsCell") as! ItemTableViewCell
        let model = viewModel.filteredRequests[indexPath.row]
        cell.itemName = model.title
        cell.duration = model.timeframe
        cell.associatedUserName = model.owner.name
        cell.price = model.price
        cell.thumbnailView.sd_setImage(with: model.thumbnailURL, completed: nil)
        cell.distance = model.distance
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - currentOffset <= 10.0 {
            ProgressView.show()
            self.viewModel.fetchItems()
        }
    }
}

// MARK: SearchBarDelegate

extension LendViewController: UISearchBarDelegate {
    private func clearSearchFilters(with text: String = "") {
        viewModel.filterRequests(withText: text)
        lendView.activeRequestsTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        clearSearchFilters(with: searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        (searchBar as? SearchBar)?.textField?.text = ""
        clearSearchFilters()
    }
}
