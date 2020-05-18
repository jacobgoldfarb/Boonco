//
//  CategorySelectorViewController.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-31.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class CategorySelectorViewController: CreationFlowViewController {
    
    let categories: [Category] = Category.allCases.sorted{ $0.description < $1.description }
    
    var selectorView: CategorySelectorView!
    
    override func loadView() {
        selectorView = CategorySelectorView()
        view = selectorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRightBarButtonText(to: "")
        selectorView.categoriesTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "categoryCell")
        selectorView.categoriesTableView.delegate = self
        selectorView.categoriesTableView.dataSource = self
    }
    
    override func handleGoForwards() {}
}

extension CategorySelectorViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.updateCategory(categories[indexPath.row])
        guard let nextVC = nextVC else { return }
        nextVC.viewModel = viewModel
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension CategorySelectorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryTableViewCell
        cell.iconView.image = Theme.standard.images.getCategoryPlaceholder()
        let selectedCategory = categories[indexPath.row]
        cell.category = selectedCategory
        return cell
    }
}

class RequestCategorySelectorViewController: CategorySelectorViewController {
    override var nextVC: CreationFlowViewController {
        return RequestCreatorDetailsViewController()
    }
    override var navigationTitle: String {
        return "Borrow Something"
    }
}

class RentalCategorySelectorViewController: CategorySelectorViewController {
    override var nextVC: CreationFlowViewController {
        return RentalCreatorDetailsViewController()
    }
    override var navigationTitle: String {
        return "Lend Something"
    }
}
