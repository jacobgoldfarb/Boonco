//
//  MockActivityService.swift
//  BooncoTests
//
//  Created by Peter Huang on 2020-05-02.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation
@testable import Boonco

struct MockActivityService: ActivityServiceable, ActivityDetailServiceable {

    //MARK: Activity
    
    func getBids(completion: @escaping ([Bid]?, Error?) -> ()) {
        let currentRentalBids: [Bid]? = DataGenerator.generateFakeRentalBids(number: 2)
        let currentRequestBids: [Bid]? = DataGenerator.generateFakeRequestBids(number: 3)
        let allBids: [Bid]? = (currentRentalBids ?? []) + (currentRequestBids ?? [])
        completion(allBids, nil)
    }
    
    //MARK: Activity Detail
    
    func approve(bid: Bid, completion: @escaping (Error?) -> ()) {
        completion(nil)
    }
    
    func reject(bid: Bid, completion: @escaping (Error?) -> ()) {
        completion(nil)
    }
    
    func blockUser(_ blockUserRequest: BlockUserRequest, completion: @escaping (Error?) -> ()) {
        completion(nil)
    }
    
    func reportUser(_ reportUserRequest: ReportUserRequest, completion: @escaping (Error?) -> ()) {
        completion(nil)
    }
}

//MARK: Activity (Main) - Delegate

class MockActivityViewModelDelegate: ActivityViewModelDelegate {
    
    var didFetchBidsCalled = false
    
    func didFetchBids() {
        didFetchBidsCalled = true
    }
}

//MARK: Activity Detail - Delegate

class MockActivityDetailViewModelDelegate: ActivityDetailViewModelDelegate {
  
    var didApproveBidCalled = false
    var didFailApprovingBidCalled = false
    var didRejectBidCalled = false
    var didFailRejectingBidCalled = false
    var didBlockUserCalled = false
    var didFailBlockingUserCalled = false
    var didReportUserCalled = false
    var didFailReportingUserCalled = false
    
    func didApproveBid() {
        didApproveBidCalled = true
    }
    
    func didFailApprovingBid(withError error: Error) {
        didFailApprovingBidCalled = true
    }
    
    func didRejectBid() {
        didRejectBidCalled = true
    }
    
    func didFailRejectingBid(withError error: Error) {
        didFailRejectingBidCalled = true
    }
    
    func didBlockUser() {
        didBlockUserCalled = true
    }
    
    func didFailBlockingUser(withError error: Error) {
        didFailBlockingUserCalled = true
    }
    
    func didReportUser() {
        didReportUserCalled = true
    }
    
    func didFailReportingUser(withError error: Error) {
        didFailReportingUserCalled = true
    }
}
