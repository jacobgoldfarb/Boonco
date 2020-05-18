//
//  RentalItemDetailViewModel.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-31.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit.UIImage

protocol ItemDetailViewModelDelegate {
    func didRequestItemDeletion()
    func didRequestBidDeletion()
    func didFinishRequesting(item: Item)
    func didFinishDownloadingImage(_ image: UIImage)
    func didFailRequesting(item: Item, withError error: Error)
    func didFinishCancelingRequest(for item: Item)
    func didFinishDeletingItem()
    func didReportItem()
    func didFailReportingItem(withError error: Error)
}

class ItemDetailViewModel {
    
    var item: Item
    var itemImage: UIImage?
    var bid: Bid?
    let service: MarketServiceable!
    var delegate: ItemDetailViewModelDelegate!
    
    
    init(model: Item, service: MarketServiceable = MarketService()) {
        item = model
        self.service = service
    }
    
    func fetchItemImage() {
        guard let url = item.imageURL else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.itemImage = image
                self.delegate.didFinishDownloadingImage(image)
            }
        }.resume()
    }
    
    func didPressItemAction() {
        guard let authenticatedUser = AuthState.shared.getUser() else {
            print("Tried to action on item, not authorized")
            return
        }
        if item.owner == authenticatedUser {
            handleDeleteAction(onItemWithId: item.id)
            return
        }
        switch item.status {
        case .open:
            handleBiddedAction(onItemWithId: item.id)
        case .biddedOn:
            handleCancelAction(forUser: authenticatedUser)            
        default:
            return
        }
    }
    
    func deleteBid() {
        guard let bid = bid else { return }
        service.cancelRequest(bidId: bid.id) { error in
            self.item.status = .open
            self.delegate.didFinishCancelingRequest(for: self.item)
        }
    }
    
    func deleteItem() {
        let itemId = item.id
        service.deleteItem(withId: itemId) { error in
            guard error == nil else { return }
            self.delegate.didFinishDeletingItem()
        }
    }
    
    func handleCancelAction(forUser user: User) {
        delegate.didRequestBidDeletion()
    }
    
    func handleBiddedAction(onItemWithId id: String) {
        service.postBid(onItemWithId: id) { bid, error in
            self.bid = bid
            self.item.status = .biddedOn
            self.delegate.didFinishRequesting(item: self.item)
        }
    }
    
    func handleDeleteAction(onItemWithId id: String) {
        delegate.didRequestItemDeletion()
    }
    
    func reportItem(with message: String) {
        let activeUserId = AuthState.shared.getUser()?.id ?? "-1"
        let reportItemRequest = ReportItemRequest(reportedById: activeUserId, itemId: item.id, message: message)
        
        service.reportItem(reportItemRequest) { error in
            guard error == nil else {
                self.delegate.didFailReportingItem(withError: error!)
                return
            }
            self.delegate.didReportItem()
        }
    }
}
