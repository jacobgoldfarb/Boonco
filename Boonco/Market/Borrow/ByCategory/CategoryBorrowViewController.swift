//
//  CategoryBorrowViewController.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-21.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class CategoryBorrowViewController: UIViewController {
    
    var categoryView: BorrowByCategoryView!
    var viewModel: BorrowByCategoryViewModel!
    lazy var searchBar = SearchBar(frame: CGRect.zero)
    
    var tableViewReuseIdentifier = "listingsCell"
    
    override func loadView() {
        categoryView = BorrowByCategoryView(frame: CGRect.zero)
        categoryView.tableViewHeader = viewModel.category.description
        view = categoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .white
        setupTableView()
        setupNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidLayoutSubviews() {
        categoryView.categoryFilteredRentalsTableView.updateCellSeparatorLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        categoryView.categoryFilteredRentalsTableView.updateCellSeparatorLayout(isExiting: true)
    }
    
    private func setupTableView() {
        categoryView.categoryFilteredRentalsTableView.delegate = self
        categoryView.categoryFilteredRentalsTableView.dataSource = self
        categoryView.categoryFilteredRentalsTableView.register(ItemTableViewCell.self, forCellReuseIdentifier: tableViewReuseIdentifier)
        categoryView.refreshControl.addTarget(self, action:  #selector(refreshTableView), for: .valueChanged)
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
            //.font: UIFont.systemFont(ofSize: 17)
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
    }
    
    @objc private func refreshTableView() {
        viewModel.fetchItems()
    }
}

// MARK: ViewModelDelegate

extension CategoryBorrowViewController: BorrowByCategoryViewModelDelegate {
    func didFetchItems() {
        categoryView.categoryFilteredRentalsTableView.reloadData()
        categoryView.refreshControl.endRefreshing()
        ProgressView.dismiss()
    }
    
    func didNotFetchItems() {
        ProgressView.dismiss(withDelay: 0.5)
    }
}

// MARK: TableView

extension CategoryBorrowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = RentalItemDetailViewController()
        let relevantModel = viewModel.filteredRentals[indexPath.row]
        detailVC.viewModel = ItemDetailViewModel(model: relevantModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension CategoryBorrowViewController: UITableViewDataSource {
    
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

extension CategoryBorrowViewController: UISearchBarDelegate {
    private func clearSearchFilters(with text: String = "") {
        viewModel.filterRentals(withText: text)
        categoryView.categoryFilteredRentalsTableView.reloadData()
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
