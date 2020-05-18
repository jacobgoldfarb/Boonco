//
//  BorrowByCategoryViewModel.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-21.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

protocol BorrowByCategoryViewModelDelegate {
    func didFetchItems()
    func didNotFetchItems()
}

class BorrowByCategoryViewModel {
    
    let marketService = MarketService()
    let delegate: BorrowByCategoryViewModelDelegate
    
    var rentals: [Rental]
    var filteredRentals: [Rental]
    let category: Category
    
    init(delegate: BorrowByCategoryViewModelDelegate, rentals: [Rental], category: Category) {
        self.delegate = delegate
        self.rentals = rentals
        self.category = category
        self.filteredRentals = rentals
    }
    
    func fetchItems() {
        delegate.didFetchItems()
    }
    
    func filterRentals(withText text: String) {
        guard text != "" else {
            return filteredRentals = rentals
        }
        let term = text.lowercased()
        filteredRentals = rentals.filter { rental -> Bool in
            return rental.title.lowercased().contains(term)
        }
    }
}
