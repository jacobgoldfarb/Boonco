//
//  OfferingsViewModel.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-29.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation
import Fakery

protocol BorrowViewModelDelegate {
    func didFetchItems()
    func didFailFetchingItems()
}

class BorrowViewModel {
    
    let service: MarketServiceable!
    let delegate: BorrowViewModelDelegate
    
    var nextPage = 1
    var isFetchingItems = false
    var nearYouRentals: [Rental] = [Rental]()
    var filteredRentals: [Rental] = [Rental]()
    var categories: [Category] = Category.allCases.sorted { $0.description < $1.description }
    let categoryIcons = [UIImage(color: Theme.standard.colors.primary),
                         UIImage(color: Theme.standard.colors.secondary),
                         UIImage(color: Theme.standard.colors.violetBlue),
                         UIImage(color: Theme.standard.colors.skyBlue),
                         UIImage(color: Theme.standard.colors.jetGray),
                         UIImage(color: Theme.standard.colors.secondary),
                         UIImage(color: Theme.standard.colors.violetBlue),
                         UIImage(color: Theme.standard.colors.skyBlue),
                         UIImage(color: Theme.standard.colors.primary),
                         UIImage(color: Theme.standard.colors.secondary),
                         UIImage(color: Theme.standard.colors.skyBlue)]
    
    init(delegate: BorrowViewModelDelegate, service: MarketServiceable = MarketService()) {
        self.delegate = delegate
        self.service = service
    }
    
    func fetchItems() {
        guard isFetchingItems == false else { return }
        isFetchingItems = true
        service.getRentals(forPage: nextPage) { (items, error) in
            self.isFetchingItems = false
            guard error == nil else {
                self.isFetchingItems = false
                self.delegate.didFailFetchingItems()
                return
            }
            self.nextPage += 1
            print("Did fetch items")
            print("New page: \(self.nextPage)")
            self.nearYouRentals.append(contentsOf: items as! [Rental])
            self.filteredRentals.append(contentsOf: items as! [Rental])
            self.delegate.didFetchItems()
            self.isFetchingItems = false
        }
    }
    
    func filterRentals(withText text: String) {
        guard text != "" else {
            return filteredRentals = nearYouRentals
        }
        let term = text.lowercased()
        filteredRentals = nearYouRentals.filter { rental -> Bool in
            return rental.title.lowercased().contains(term)
        }
    }
}
