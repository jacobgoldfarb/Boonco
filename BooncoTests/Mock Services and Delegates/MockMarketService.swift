//
//  MockMarketService.swift
//  BooncoTests
//
//  Created by Peter Huang on 2020-05-03.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation
import UIKit.UIImage
@testable import Boonco

struct MockMarketService: MarketServiceable {
    func getRentals(forPage page: Int, completion: @escaping ([Item]?, Error?) -> ()) {
        let currentRentals: [Item]? = DataGenerator.generateFakeRentals(number: 3)
        completion(currentRentals, nil)
    }
    
    func getRequests(forPage page: Int, completion: @escaping ([Item]?, Error?) -> ()) {
        let currentRequests: [Item]? = DataGenerator.generateFakeRequests(number: 3)
        completion(currentRequests, nil)
    }
    
    func cancelRequest(bidId: String, completion: @escaping (Error?) -> ()) {
        completion(nil)
    }
    
    func postBid(onItemWithId id: String, completion: @escaping (Bid?, Error?) -> ()) {
        let currentBid: Bid? = DataGenerator.generateFakeRequestBids(number: 1).first
        completion(currentBid, nil)
    }
    
    func deleteItem(withId id: String, completion: @escaping (Error?) -> ()) {
        completion(nil)
    }
    
    func reportItem(_ reportItemRequest: ReportItemRequest, completion: @escaping (Error?) -> ()) {
        completion(nil)
    }
    
    func blockUser(_ blockUserRequest: BlockUserRequest, completion: @escaping (Error?) -> ()) {
        completion(nil)
    }
    
    func reportUser(_ reportUserRequest: ReportUserRequest, completion: @escaping (Error?) -> ()) {
        completion(nil)
    }
}

//MARK: Borrow Tab - Delegate

class MockBorrowViewModelDelegate: BorrowViewModelDelegate {
    
    var didFetchItemsCalled = false
    var didNotFetchItemsCalled = false
    
    func didFetchItems() {
        didFetchItemsCalled = true
    }
    
    func didFailFetchingItems() {
        didNotFetchItemsCalled = true
    }
}

//MARK: Lend Tab - Delegate

class MockLendViewModelDelegate: LendViewModelDelegate {
    
    var didFetchItemsCalled = false
    var didNotFetchItemsCalled = false
    
    func didFetchItems() {
        didFetchItemsCalled = true
    }
    
    func failedFetchingItems() {
        didNotFetchItemsCalled = true
    }
}

//MARK: Item Detail View - Delegate

class MockItemDetailViewModelDelegate: ItemDetailViewModelDelegate {
    
    var didRequestItemDeletionCalled = false
    var didRequestBidDeletionCalled = false
    var didFinishRequestionItemCalled = false
    var didFinishDownloadingImageCalled = false
    var didFailRequestingItemCalled = false
    var didFinishCancelingRequestCalled = false
    var didFinishDeletingItemCalled = false
    var didReportItemCalled = false
    var didFailReportingItemCalled = false
    
    func didRequestItemDeletion() {
        didRequestItemDeletionCalled = true
    }
    
    func didRequestBidDeletion() {
        didRequestBidDeletionCalled = true
    }
    
    func didFinishRequesting(item: Item) {
        didFinishRequestionItemCalled = true
    }
    
    func didFinishDownloadingImage(_ image: UIImage) {
        didFinishDownloadingImageCalled = true
    }
    
    func didFailRequesting(item: Item, withError error: Error) {
        didFailRequestingItemCalled = true
    }
    
    func didFinishCancelingRequest(for item: Item) {
        didFinishCancelingRequestCalled = true
    }
    
    func didFinishDeletingItem() {
        didFinishDeletingItemCalled = true
    }
    
    func didReportItem() {
        didReportItemCalled = true
    }
    
    func didFailReportingItem(withError error: Error) {
        didFailReportingItemCalled = true
    }
    
    func resetDelegateFunctionsCalled() {
        didRequestItemDeletionCalled = false
        didRequestBidDeletionCalled = false
        didFinishRequestionItemCalled = false
        didFinishDownloadingImageCalled = false
        didFailRequestingItemCalled = false
        didFinishCancelingRequestCalled = false
        didFinishDeletingItemCalled = false
        didReportItemCalled = false
        didFailReportingItemCalled = false
    }
}

//MARK: Market Activity Item Detail View - Delegate

class MockMarketActivityDetailViewModelDelegate: MarketActivityDetailViewModelDelegate {
    var didRequestBidDeletionCalled = false
    var didFinishRequestingCalled = false
    var didFinishDownloadingImageCalled = false
    var didFailRequestingCalled = false
    var didFinishCancelingRequestCalled = false
    var didReportItemCalled = false
    var didFailReportingItemCalled = false
    var didBlockUserCalled = false
    var didFailBlockingUserCalled = false
    var didReportUserCalled = false
    var didFailReportingUserCalled = false
    
    
    func didRequestBidDeletion() {
        didRequestBidDeletionCalled = true
    }
    
    func didFinishRequesting(item: Item) {
        didFinishRequestingCalled = true
    }
    
    func didFinishDownloadingImage(_ image: UIImage) {
        didFinishDownloadingImageCalled = true
    }
    
    func didFailRequesting(bid: Bid, withError error: Error) {
        didFailRequestingCalled = true
    }
    
    func didFinishCancelingRequest(for bid: Bid) {
        didFinishCancelingRequestCalled = true
    }
    
    func didReportItem() {
        didReportItemCalled = true
    }
    
    func didFailReportingItem(withError error: Error) {
        didFailReportingItemCalled = true
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
    
    func resetDelegateFunctionsCalled() {
        didRequestBidDeletionCalled = false
        didFinishRequestingCalled = false
        didFinishDownloadingImageCalled = false
        didFailRequestingCalled = false
        didFinishCancelingRequestCalled = false
        didReportItemCalled = false
        didFailReportingItemCalled = false
        didBlockUserCalled = false
        didFailBlockingUserCalled = false
        didReportUserCalled = false
        didFailReportingUserCalled = false
    }
}
