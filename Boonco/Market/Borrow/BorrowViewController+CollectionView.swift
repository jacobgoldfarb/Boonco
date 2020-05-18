//
//  BorrowViewController+CollectionView.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-21.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

extension BorrowViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewReuseIdentifier, for: indexPath as IndexPath) as! CategoryCollectionViewCell
        let cat = viewModel.categories[indexPath.row]
        cell.icon = viewModel.categoryIcons[indexPath.row]
        cell.categoryText = cat.description
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CategoryBorrowViewController()
        let category = viewModel.categories[indexPath.row]
        let categoryRentals = viewModel.nearYouRentals.filter { rental -> Bool in
            return rental.category == category
        }
        let viewModel = BorrowByCategoryViewModel(delegate: vc, rentals: categoryRentals, category: category)
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
}
