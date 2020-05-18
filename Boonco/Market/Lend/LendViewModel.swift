//
//  RequestsViewModel.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-30.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit.UIImage

protocol LendViewModelDelegate {
    func didFetchItems()
    func failedFetchingItems()
}

class LendViewModel {
    
    let service: MarketServiceable!
    let delegate: LendViewModelDelegate
    var nextPage = 1
    var isFetchingItems = false
    var nearYouRequests: [Request] = [Request]()
    var filteredRequests: [Request] = [Request]()
    
    init(delegate: LendViewModelDelegate, service: MarketServiceable = MarketService()) {
        self.delegate = delegate
        self.service = service
    }
    
    func fetchItems() {
        guard isFetchingItems == false else { return }
        isFetchingItems = true
        service.getRequests(forPage: nextPage) { (items, error) in
            guard error == nil else {
                self.isFetchingItems = false
                self.delegate.failedFetchingItems()
                return
            }
            self.nextPage += 1
            self.nearYouRequests.append(contentsOf: items as! [Request])
            self.filteredRequests.append(contentsOf: items as! [Request])
            self.delegate.didFetchItems()
            self.isFetchingItems = false
        }
    }
    
    func filterRequests(withText text: String) {
        guard text != "" else {
            return filteredRequests = nearYouRequests
        }
        let term = text.lowercased()
        filteredRequests = nearYouRequests.filter { rental -> Bool in
            return rental.title.lowercased().contains(term)
        }
    }
}
