//
//  MarketTests.swift
//  BooncoTests
//
//  Created by Peter Huang on 2020-05-03.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import XCTest
@testable import Boonco

class MarketTests: XCTestCase {
    
    var borrowVM: BorrowViewModel!
    var lendVM: LendViewModel!
    var borrowItemDetailVM: ItemDetailViewModel!
    var lendItemDetailVM: ItemDetailViewModel!
    var listingActivityDetailVM: MarketActivityDetailViewModel!
    var requestActivityDetailVM: MarketActivityDetailViewModel!
    
    let borrowVMDelegate = MockBorrowViewModelDelegate()
    let lendVMDelegate = MockLendViewModelDelegate()
    let itemDetailVMDelegate = MockItemDetailViewModelDelegate()
    let marketActivityVMDelegate = MockMarketActivityDetailViewModelDelegate()
    
    let currentBids: [Bid] = DataGenerator.generateFakeRentalBids(number: 2)
    
    override func setUp() {
        let service = MockMarketService()
        borrowVM = BorrowViewModel(delegate: borrowVMDelegate, service: service)
        lendVM = LendViewModel(delegate: lendVMDelegate, service: service)
        
        let borrowItem = DataGenerator.generateFakeRental()
        let lendItem = DataGenerator.generateFakeRequest()
        borrowItemDetailVM = ItemDetailViewModel(model: borrowItem, service: service)
        lendItemDetailVM = ItemDetailViewModel(model: lendItem, service: service)
        borrowItemDetailVM.delegate = itemDetailVMDelegate
        lendItemDetailVM.delegate = itemDetailVMDelegate
        
        let currentRentalBid: Bid = DataGenerator.generateFakeRentalBids(number: 1).first!
        listingActivityDetailVM = MarketActivityDetailViewModel(model: currentRentalBid, service: service)
        listingActivityDetailVM.delegate = marketActivityVMDelegate
        
        let currentRequestBid: Bid = DataGenerator.generateFakeRequestBids(number: 1).first!
        requestActivityDetailVM = MarketActivityDetailViewModel(model: currentRequestBid, service: service)
        requestActivityDetailVM.delegate = marketActivityVMDelegate
    }
    
    //MARK: Test Borrow View Model
    
    func testBorrowTabFetchItems() throws {
        borrowVM.fetchItems()
        XCTAssertTrue(borrowVMDelegate.didFetchItemsCalled)
    }
    
    //MARK: Test Lend View Model
    
    func testLendTabFetchItems() throws {
        lendVM.fetchItems()
        XCTAssertTrue(lendVMDelegate.didFetchItemsCalled)
    }
    
    //MARK: Test Item Detail View Model
    
    func testBorrowDeleteItem() throws {
        itemDetailVMDelegate.resetDelegateFunctionsCalled()
        borrowItemDetailVM.deleteItem()
        XCTAssertTrue(itemDetailVMDelegate.didFinishDeletingItemCalled)
    }
    
    func testLendDeleteItem() throws {
        itemDetailVMDelegate.resetDelegateFunctionsCalled()
        lendItemDetailVM.deleteItem()
        XCTAssertTrue(itemDetailVMDelegate.didFinishDeletingItemCalled)
    }
    
    func testBorrowDeleteBid() throws {
        let currentBid: Bid = DataGenerator.generateFakeBid(on: borrowItemDetailVM.item)
        borrowItemDetailVM.bid = currentBid
        
        itemDetailVMDelegate.resetDelegateFunctionsCalled()
        borrowItemDetailVM.deleteBid()
        XCTAssertTrue(itemDetailVMDelegate.didFinishCancelingRequestCalled)
    }
    
    func testLendDeleteBid() throws {
        let currentBid: Bid = DataGenerator.generateFakeBid(on: lendItemDetailVM.item)
        lendItemDetailVM.bid = currentBid
        
        itemDetailVMDelegate.resetDelegateFunctionsCalled()
        lendItemDetailVM.deleteBid()
        XCTAssertTrue(itemDetailVMDelegate.didFinishCancelingRequestCalled)
    }
    
    func testPostBorrowingBid() throws {
        let currentBid: Bid = DataGenerator.generateFakeBid(on: borrowItemDetailVM.item)
        borrowItemDetailVM.bid = currentBid
        
        itemDetailVMDelegate.resetDelegateFunctionsCalled()
        borrowItemDetailVM.handleBiddedAction(onItemWithId: borrowItemDetailVM.item.id)
        XCTAssertTrue(itemDetailVMDelegate.didFinishRequestionItemCalled)
    }
    
    func testPostLendingBid() throws {
        let currentBid: Bid = DataGenerator.generateFakeBid(on: lendItemDetailVM.item)
        lendItemDetailVM.bid = currentBid
        
        itemDetailVMDelegate.resetDelegateFunctionsCalled()
        lendItemDetailVM.handleBiddedAction(onItemWithId: lendItemDetailVM.item.id)
        XCTAssertTrue(itemDetailVMDelegate.didFinishRequestionItemCalled)
    }
    
    func testReportItem() throws {
        borrowItemDetailVM.reportItem(with: "Reporting item")
        XCTAssertTrue(itemDetailVMDelegate.didReportItemCalled)
    }
    
     //MARK: Test Market Activity Detail View Model
        
    func testActivityListingDeleteBid() throws {
        marketActivityVMDelegate.resetDelegateFunctionsCalled()
        listingActivityDetailVM.deleteBid()
        XCTAssertTrue(marketActivityVMDelegate.didFinishCancelingRequestCalled)
    }
    
    func testActivityRequestDeleteBid() throws {
        marketActivityVMDelegate.resetDelegateFunctionsCalled()
        requestActivityDetailVM.deleteBid()
        XCTAssertTrue(marketActivityVMDelegate.didFinishCancelingRequestCalled)
    }
    
    func testActivityListingPostBid() throws {
        marketActivityVMDelegate.resetDelegateFunctionsCalled()
        listingActivityDetailVM.handleBiddedAction(onItemWithId: listingActivityDetailVM.bid.item.id)
        XCTAssertTrue(marketActivityVMDelegate.didFinishRequestingCalled)
    }
    
    func testActivityRequestPostBid() throws {
        marketActivityVMDelegate.resetDelegateFunctionsCalled()
        requestActivityDetailVM.handleBiddedAction(onItemWithId: requestActivityDetailVM.bid.item.id)
        XCTAssertTrue(marketActivityVMDelegate.didFinishRequestingCalled)
    }
    
    func testActivityReportItem() throws {
        listingActivityDetailVM.reportItem(with: "Reporting item")
        XCTAssertTrue(marketActivityVMDelegate.didReportItemCalled)
    }
    
    func testActivityBlockUser() throws {
        listingActivityDetailVM.blockUser()
        XCTAssertTrue(marketActivityVMDelegate.didBlockUserCalled)
    }
    
    func testActivityReportUser() throws {
        listingActivityDetailVM.reportUser()
        XCTAssertTrue(marketActivityVMDelegate.didReportUserCalled)
    }
}
