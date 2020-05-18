//
//  ActivityViewModel.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-02.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

protocol ActivityViewModelDelegate {
    func didFetchBids()
}

class ActivityViewModel {
    
    let service: ActivityServiceable!
    let delegate: ActivityViewModelDelegate!
    
    var myRequestResponses = [Bid]()
    var myRentalResponses = [Bid]()
    var requestBidActivity = [Bid]()
    var rentalBidActivity = [Bid]()
    
    init(delegate: ActivityViewModelDelegate, service: ActivityServiceable = ActivityService()) {
        self.delegate = delegate
        self.service = service
    }
    
    func fetchBids() {
        service.getBids { bids, error  in
            guard error == nil else {
                return
            }
            guard let bids = bids else {
                return
            }
            self.setBiddedRequests(bids)
            self.setBiddedRentals(bids)
            self.setRequestResponses(bids)
            self.setRentalResponses(bids)
            self.delegate.didFetchBids()
        }
    }
    
    private func setBiddedRequests(_ bids: [Bid]) {
        self.requestBidActivity = bids.filter { bid -> Bool in
            let isBidCreator = bid.bidder == AuthState.shared.getUser()
            let bidIsRequest = bid.item as? Request != nil ? true : false
            return isBidCreator && bidIsRequest
        }.map { bid -> Bid in
            var newBid = bid
            if newBid.item.status == .open {
                newBid.item.status = .biddedOn
            }
            return newBid
        }
    }
    
    private func setBiddedRentals(_ bids: [Bid]) {
        self.rentalBidActivity = bids.filter { bid -> Bool in
            let isBidCreator = bid.bidder == AuthState.shared.getUser()
            let bidIsRental = bid.item as? Rental != nil ? true : false
            return isBidCreator && bidIsRental
        }.map { bid -> Bid in
            var newBid = bid
            if newBid.item.status == .open {
                newBid.item.status = .biddedOn
            }
            return newBid
        }
    }
    
    private func setRequestResponses(_ bids: [Bid]) {
        self.myRequestResponses = bids.filter { bid -> Bool in
            let isItemCreator = bid.item.owner == AuthState.shared.getUser()
            let bidIsRequest = bid.item as? Request != nil ? true : false
            return isItemCreator && bidIsRequest
        }
    }
    
    private func setRentalResponses(_ bids: [Bid]) {
        self.myRentalResponses = bids.filter { bid -> Bool in
            let isItemCreator = bid.item.owner == AuthState.shared.getUser()
            let bidIsRental = bid.item as? Rental != nil ? true : false
            return isItemCreator && bidIsRental
        }
    }
}
