//
//  ActivityViewController+TableView.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-03.
//

import UIKit

extension ActivityViewController {
    private func getNumberOfRows(forTag tag: Int, segment: ActivitySegment) -> Int {
        switch segment {
        case .market:
            return tag == 0 ? viewModel.rentalBidActivity.count : viewModel.requestBidActivity.count
        case .posts:
            return tag == 0 ? viewModel.myRentalResponses.count : viewModel.myRequestResponses.count
        }
    }
    
    private func getBidsModel(forTag tag: Int, row: Int) -> Bid {
        return tag == 0 ? viewModel.myRentalResponses[row] : viewModel.myRequestResponses[row]
    }
    
    private func getMarketModel(forTag tag: Int, row: Int) -> Bid {
        return tag == 0 ? viewModel.rentalBidActivity[row] : viewModel.requestBidActivity[row]
    }
}

extension ActivityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = getDetailViewController(for: activeSegment, tableViewTag: tableView.tag, row: indexPath.row)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func getDetailViewController(for segment: ActivitySegment, tableViewTag tag: Int, row: Int) -> UIViewController {
        switch segment {
        case .posts:
            let activityDetailVC = ActivityDetailViewController()
            let model = getBidsModel(forTag: tag, row: row)
            let viewModel = ActivityDetailViewModel(bid: model)
            activityDetailVC.viewModel = viewModel
            return activityDetailVC
        case .market:
            let itemDetailVC = MarketActivityDetailViewController()
            let model = getMarketModel(forTag: tag, row: row)
            let viewModel = MarketActivityDetailViewModel(model: model)
            viewModel.bid = model
            itemDetailVC.viewModel = viewModel
            return itemDetailVC
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return activityView.peekComponentHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let fadeView = UIView()
        
        let gradient = CAGradientLayer()
        gradient.frame.size = CGSize(width: tableView.bounds.width, height: activityView.peekComponentHeight)
        let stopColor = UIColor.white.cgColor
        let startColor = UIColor.white.withAlphaComponent(0).cgColor
        gradient.colors = [startColor, stopColor]
        gradient.locations = [0.1, 1.0]
        fadeView.layer.addSublayer(gradient)
        
        return fadeView
    }
}

extension ActivityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getNumberOfRows(forTag: tableView.tag, segment: activeSegment)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch activeSegment {
        case .posts:
            cell = tableView.dequeueReusableCell(withIdentifier: "myListingsCell")!
            let model = getBidsModel(forTag: tableView.tag, row: indexPath.row)
            bindBidsModel(model, toCell: cell as! ItemTableViewCell)
        case .market:
            cell = tableView.dequeueReusableCell(withIdentifier: "marketCell")!
            let model = getMarketModel(forTag: tableView.tag, row: indexPath.row)
            bindItemModel(model.item, toPostCell: cell as! BiddedMarketItemTableViewCell)
        case .none:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    private func bindBidsModel(_ model: Bid, toCell cell: ItemTableViewCell) {
        cell.itemName = model.item.title
        cell.duration = model.item.timeframe
        cell.associatedUserName = model.bidder.name
        cell.price = model.item.price
        cell.thumbnailView.sd_setImage(with: model.item.thumbnailURL, completed: nil)
        cell.distance = model.item.distance
    }
    
    private func bindItemModel(_ model: Item, toPostCell cell: BiddedMarketItemTableViewCell) {
        cell.itemName = model.title
        cell.duration = model.timeframe
        cell.associatedUserName = model.owner.name
        cell.price = model.price
        cell.status = model.status
        cell.thumbnailView.sd_setImage(with: model.thumbnailURL, completed: nil)
    }
}
