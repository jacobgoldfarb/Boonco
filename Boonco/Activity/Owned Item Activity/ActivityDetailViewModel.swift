//
//  ActivityDetailViewModel.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-02.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

protocol ActivityDetailViewModelDelegate {
    func didApproveBid()
    func didFailApprovingBid(withError error: Error)
    func didRejectBid()
    func didFailRejectingBid(withError error: Error)
    func didBlockUser()
    func didFailBlockingUser(withError error: Error)
    func didReportUser()
    func didFailReportingUser(withError error: Error)
}

class ActivityDetailViewModel {
    
    var bid: Bid
    let service: ActivityDetailServiceable!
    var delegate: ActivityDetailViewModelDelegate!
    
    init(bid: Bid, service: ActivityDetailServiceable = ActivityService()) {
        self.bid = bid
        self.service = service
    }
    
    func approveBid() {
        service.approve(bid: bid) { error in
            guard error == nil else {
                self.delegate.didFailApprovingBid(withError: error!)
                return
            }
            self.bid.status = .accepted
            self.delegate.didApproveBid()
        }
    }
    
    func rejectBid() {
        service.reject(bid: bid) { error in
            guard error == nil else {
                self.delegate.didFailRejectingBid(withError: error!)
                return
            }
            self.bid.status = .rejected
            self.delegate.didRejectBid()
        }
    }
    
    func blockUser(_ message: String = "Blocking user") {
        let activeUserId = AuthState.shared.getUser()?.id ?? "-1" //TODO: switch to guard, create new error type
        let blockUserRequest = BlockUserRequest(blockedUserId: bid.bidder.id, blockedById: activeUserId)
        
        service.blockUser(blockUserRequest) { error in
            guard error == nil else {
                self.delegate.didFailBlockingUser(withError: error!)
                return
            }
            self.delegate.didBlockUser()
        }
    }
    
    func reportUser(with message: String = "Reporting user") {
        let activeUserId = AuthState.shared.getUser()?.id ?? "-1" //TODO: switch to guard, create new error type
        let reportUserRequest = ReportUserRequest(reportedById: activeUserId, reporteeId: bid.bidder.id, message: message)
        
        service.reportUser(reportUserRequest) { error in
            guard error == nil else {
                self.delegate.didFailReportingUser(withError: error!)
                return
            }
            self.delegate.didReportUser()
        }
    }
}
