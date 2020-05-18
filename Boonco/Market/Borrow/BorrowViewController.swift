//
//  BorrowViewController.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-26.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class BorrowViewController: UIViewController {
    
    var borrowView: BorrowView!
    var viewModel: BorrowViewModel!
    lazy var searchBar = SearchBar(frame: CGRect.zero)
    var offeringFlowVC: UINavigationController {
        let offeringFlowVC = UINavigationController(rootViewController: RentalPhotosUploaderViewController())
        offeringFlowVC.modalPresentationStyle = .fullScreen
        return offeringFlowVC
    }
    
    var tableViewReuseIdentifier = "listingsCell"
    var collectionViewReuseIdentifier = "categoryCell"

    override func loadView() {
        borrowView = BorrowView(frame: CGRect.zero)
        borrowView.createItemButton.addTarget(self, action: #selector(handleCreateOfferingTap(_:)), for: .touchUpInside)
        view = borrowView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressView.show()
        view.backgroundColor = .white
        setupTableView()
        setupCollectionView()
        setupNavigationBar()
        viewModel = BorrowViewModel(delegate: self)
        viewModel.fetchItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchItems()
        borrowView.updateView()
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidLayoutSubviews() {
        borrowView.activeRentalsTableView.updateCellSeparatorLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        borrowView.activeRentalsTableView.updateCellSeparatorLayout(isExiting: true)
    }
    
    private func setupTableView() {
        borrowView.activeRentalsTableView.delegate = self
        borrowView.activeRentalsTableView.dataSource = self
        borrowView.activeRentalsTableView.register(ItemTableViewCell.self, forCellReuseIdentifier: tableViewReuseIdentifier)
        borrowView.refreshControl.addTarget(self, action:  #selector(refreshTableView), for: .valueChanged)
    }
    
    private func setupCollectionView() {
        borrowView.categoriesView.collectionView.delegate = self
        borrowView.categoriesView.collectionView.dataSource = self
        borrowView.categoriesView.collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: collectionViewReuseIdentifier)
    }
    
    //MARK: Navigation
    
    private func setupNavigationBar() {
        setupSearchBar()
        navigationController?.navigationBar.clipsToBounds = false
        navigationController?.navigationBar.barTintColor = Theme.standard.colors.primary
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        setupSearchBarCancel()
    }
    
    private func setupSearchBarCancel() {
        let attributes:[NSAttributedString.Key: Any] = [
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

extension BorrowViewController: BorrowViewModelDelegate {
    func didFetchItems() {
        borrowView.activeRentalsTableView.reloadData()
        borrowView.refreshControl.endRefreshing()
        ProgressView.dismiss()
    }
    
    func didFailFetchingItems() {
        borrowView.refreshControl.endRefreshing()
        ProgressView.dismiss()
    }
}

// MARK: TableView

extension BorrowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = RentalItemDetailViewController()
        let relevantModel = viewModel.filteredRentals[indexPath.row]
        detailVC.viewModel = ItemDetailViewModel(model: relevantModel)
        navigationController?.pushViewController(detailVC, animated: true)
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

extension BorrowViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredRentals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewReuseIdentifier) as! ItemTableViewCell
        let model = viewModel.filteredRentals[indexPath.row]
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
}

// MARK: SearchBarDelegate

extension BorrowViewController: UISearchBarDelegate {
    private func clearSearchFilters(with text: String = "") {
        viewModel.filterRentals(withText: text)
        borrowView.activeRentalsTableView.reloadData()
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
