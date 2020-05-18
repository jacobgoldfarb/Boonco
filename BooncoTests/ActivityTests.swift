//
//  ActivityTests.swift
//  BooncoTests
//
//  Created by Peter Huang on 2020-05-02.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import XCTest
@testable import Boonco

class ActivityTests: XCTestCase {
    
    let activityDelegate = MockActivityViewModelDelegate()
    var activityVM: ActivityViewModel!
    
    let activityDetailDelegate = MockActivityDetailViewModelDelegate()
    var activityDetailVM: ActivityDetailViewModel!
    
    let fakeBids: [Bid] = DataGenerator.generateFakeRentalBids(number: 2)
    
    override func setUp() {
        let service = MockActivityService()
        activityVM = ActivityViewModel(delegate: activityDelegate, service: service)
        
        let bid: Bid = fakeBids.first!
        activityDetailVM = ActivityDetailViewModel(bid: bid, service: service)
        activityDetailVM.delegate = activityDetailDelegate
    }
    
    func testBidsFetched() throws {
        activityVM.fetchBids()
        XCTAssertTrue(activityDelegate.didFetchBidsCalled)
    }
    
    func testApproveBid() throws {
        activityDetailVM.approveBid()
        XCTAssertTrue(activityDetailDelegate.didApproveBidCalled)
    }
    
    func testRejectBid() throws {
        activityDetailVM.rejectBid()
        XCTAssertTrue(activityDetailDelegate.didRejectBidCalled)
    }
    
    func testBlockedUserSuccessfully() throws {
        activityDetailVM.blockUser()
        XCTAssertTrue(activityDetailDelegate.didBlockUserCalled)
    }
    
    func testReportedUserSuccessfully() throws {
        activityDetailVM.reportUser()
        XCTAssertTrue(activityDetailDelegate.didReportUserCalled)
    }
}
