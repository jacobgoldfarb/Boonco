//
//  MarketActivityViewModel.swift
//  Alamofire
//
//  Created by Jacob Goldfarb on 2020-04-20.
//

import UIKit.UIImage

protocol MarketActivityDetailViewModelDelegate {
    func didRequestBidDeletion()
    func didFinishRequesting(item: Item)
    func didFinishDownloadingImage(_ image: UIImage)
    func didFailRequesting(bid: Bid, withError error: Error)
    func didFinishCancelingRequest(for bid: Bid)
    func didReportItem()
    func didFailReportingItem(withError error: Error)
    func didBlockUser()
    func didFailBlockingUser(withError error: Error)
    func didReportUser()
    func didFailReportingUser(withError error: Error)
}

class MarketActivityDetailViewModel {
    
    var itemImage: UIImage?
    var bid: Bid
    let service: MarketServiceable!
    var delegate: MarketActivityDetailViewModelDelegate!
        
    init(model: Bid, service: MarketServiceable = MarketService()) {
        bid = model
        self.service = service
    }
    
    func fetchItemImage() {
        guard let url = bid.item.imageURL else { return }
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
            return
        }
        switch bid.item.status {
        case .open:
            handleBiddedAction(onItemWithId: bid.item.id)
        case .biddedOn:
            handleCancelAction(forUser: authenticatedUser)
        default:
            return
        }
    }
    
    func handleCancelAction(forUser user: User) {
        delegate.didRequestBidDeletion()
    }
    
    func deleteBid() {
        service.cancelRequest(bidId: bid.id) { error in
            self.bid.item.status = .open
            self.delegate.didFinishCancelingRequest(for: self.bid)
        }
    }
    
    func handleBiddedAction(onItemWithId id: String) {
        service.postBid(onItemWithId: id) { bid, error in
            self.bid = bid ?? self.bid
            self.bid.item.status = .biddedOn
            self.delegate.didFinishRequesting(item: self.bid.item)
        }
    }
    
    func reportItem(with message: String) {
        let activeUserId = AuthState.shared.getUser()?.id ?? "-1"
        let reportItemRequest = ReportItemRequest(reportedById: activeUserId, itemId: bid.item.id, message: message)
        
        service.reportItem(reportItemRequest) { error in
            guard error == nil else {
                self.delegate.didFailReportingItem(withError: error!)
                return
            }
            self.delegate.didReportItem()
        }
    }
    
    func blockUser(_ message: String = "Blocking user") {
        let activeUserId = AuthState.shared.getUser()?.id ?? "-1"
        let blockUserRequest = BlockUserRequest(blockedUserId: bid.item.owner.id, blockedById: activeUserId)
        
        service.blockUser(blockUserRequest) { error in
            guard error == nil else {
                self.delegate.didFailBlockingUser(withError: error!)
                return
            }
            self.delegate.didBlockUser()
        }
    }
    
    func reportUser(with message: String = "Reporting user") {
        let activeUserId = AuthState.shared.getUser()?.id ?? "-1"
        let reportUserRequest = ReportUserRequest(reportedById: activeUserId, reporteeId: bid.item.owner.id, message: message)
        
        service.reportUser(reportUserRequest) { error in
            guard error == nil else {
                self.delegate.didFailReportingUser(withError: error!)
                return
            }
            self.delegate.didReportUser()
        }
    }
}
