//
//  MarketActivityDetailViewController.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-19.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class MarketActivityDetailViewController: UIViewController {
    
    var viewModel: MarketActivityDetailViewModel!
    var detailView: UIView!
    var alertController: UIAlertController!
    
    override func loadView() {
        if viewModel.bid.status == .accepted {
            navigationController?.navigationBar.tintColor = .white
            detailView = makeActivityDetailView(withBid: viewModel.bid)
        } else {
            detailView = ItemDetailView()
        }
        setupAlertViewController()
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchItemImage()
        populateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let activityView = detailView as? ActivityDetailView {
            activityView.updateView()
        }
        viewModel.fetchItemImage()
    }

    private func populateView() {
        if let itemDetailView = detailView as? ItemDetailView {
            populateView(itemDetailView)
            formatNavBarClear()
        } else if let activityDetailView = detailView as? ActivityDetailView {
            populateView(activityDetailView, from: viewModel.bid)
        }
        
    }
    
    private func makeActivityDetailView(withBid bid: Bid) -> ActivityDetailView {
        let newView = ActivityDetailView()
        newView.updateProfilePreview(for: bid.status)
        newView.populateAcceptedProfileView(for: bid.item.owner)
        guard let profilePreview = newView.profilePreview as? AcceptedBidProfilePreview else {
            return newView
        }
        profilePreview.contactInfoView.phoneNumberButton.addTarget(self, action: #selector(didPressCall(_:)), for: .touchUpInside)
        profilePreview.contactInfoView.emailButton.addTarget(self, action: #selector(didPressEmail(_:)), for: .touchUpInside)
        profilePreview.additionalOptionsButton.addTarget(self, action: #selector(didPressAdditionalOptions(_:)), for: .touchUpInside)
        return newView
    }
    
    private func populateView(_ itemDetailView: ItemDetailView) {
        itemDetailView.populateView(from: viewModel.bid.item)
        itemDetailView.actionButton.addTarget(self, action: #selector(handleDidPressItemAction(_:)), for: .touchUpInside)
        itemDetailView.additionalOptionsButton.addTarget(self, action: #selector(didPressAdditionalOptions(_:)), for: .touchUpInside)
        updateView(itemDetailView, for: viewModel.bid.item)
    }
    
    private func populateView(_ activityDetailView: ActivityDetailView, from bid: Bid) {
        activityDetailView.populateProfileView(from: bid.item.owner)
        activityDetailView.populateItemView(from: bid.item)
    }
    
    private func updateView(_ itemDetailView: ItemDetailView, for item: Item) {
        itemDetailView.updateView(for: item)
    }
    
    private func formatNavBarClear() {
        let navBar = self.navigationController?.navigationBar
        navBar!.tintColor = Theme.standard.colors.primary
        navBar!.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar!.shadowImage = UIImage()
        navBar!.isTranslucent = true
    }
        
    @objc private func handleDidPressItemAction(_ sender: UIButton) {
        guard AuthState.shared.getUser() != nil else {
            tabBarController?.navigationController?.popToRootViewController(animated: true)
            return
        }
        viewModel.didPressItemAction()
    }
    
    @objc private func didPressCall(_ sender: UIButton) {
        guard let phoneNumber = viewModel.bid.bidder.phoneNumber,
            let url = URL(string: "tel://\(phoneNumber)") else { return }
        UIApplication.shared.open(url)
    }
    
    @objc private func didPressEmail(_ sender: UIButton) {
        let email = viewModel.bid.bidder.email
        guard let url = URL(string: "mailto:\(email)?subject=Interest%20in%20Offering%20%5BAccepted%20Request%5D") else { return }
        UIApplication.shared.open(url)
    }
    
    @objc private func didPressAdditionalOptions(_ sender: UIButton) {
        showActionSheet()
    }
    
    //MARK: Action sheet and alert view
    
    private func getActionSheet(toBlockUser: Bool) -> UIAlertController {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let alertActionTitle = toBlockUser ? "Block" : "Report"
        
        actionSheet.addAction(UIAlertAction(title: alertActionTitle, style: UIAlertAction.Style.destructive) { _ in
            self.present(self.alertController, animated: true)
        })
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel))
        return actionSheet
    }
    
    private func showActionSheet() {
        let isBlockingUser: Bool = (viewModel.bid.status == .accepted)
        let actionSheet = getActionSheet(toBlockUser: isBlockingUser)
        present(actionSheet, animated: true)
    }
    
    private func setupAlertViewController() {
        let alertTitle: String = (viewModel.bid.status == .accepted) ? "Block User?" : "Report this post?"
        let alertMessage: String = (viewModel.bid.status == .accepted) ? Theme.standard.strings.blockUserMessage : Theme.standard.strings.reportItemMessage
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let blockAction = UIAlertAction(title: "Block", style: .destructive) { (action: UIAlertAction) in
            self.viewModel.blockUser()
        }
        
        let reportAction = UIAlertAction(title: "Report", style: .destructive) { (action: UIAlertAction) in
            let reportedMessage: String = self.alertController.textFields?.first?.text ?? ""
            self.viewModel.reportItem(with: reportedMessage)
        }

        alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        if viewModel.bid.status == .accepted {
            alertController.addAction(blockAction)
        } else {
            alertController.addAction(reportAction)
            alertController.addTextField { (textfield) in
                textfield.placeholder = "Enter the description"
            }
        }
        
        alertController.addAction(cancelAction)
    }
}

// MARK: Activity detail view model delegate

extension MarketActivityDetailViewController: MarketActivityDetailViewModelDelegate {
    
    func didRequestBidDeletion() {
        let confirmVC = ConfirmationAlertController(title: "Are you sure?", message: "This item will be removed from the marketplace.", preferredStyle: UIAlertController.Style.alert)
        confirmVC.confirmCompletion = viewModel.deleteBid
        present(confirmVC, animated: true)
    }
    
    func didFinishRequesting(item: Item) {
        updateView(view as! ItemDetailView, for: item)
        let messageVC = MessageAlertController(title: "Success", message: "You can monitor this item in the 'Activity' tab.", preferredStyle: UIAlertController.Style.alert)
        present(messageVC, animated: true)
    }
    
    func didFailRequesting(bid: Bid, withError error: Error) {
        
    }
    
    func didFinishDownloadingImage(_ image: UIImage) {
        guard let itemDetailView = (detailView as? ItemDetailView) else { return }
        itemDetailView.image = image
    }
    
    func didFinishCancelingRequest(for bid: Bid) {
        updateView(view as! ItemDetailView, for: bid.item)
        print("Did finish canceling item")
    }
    
    func didFinishDeletingItem() {
        navigationController?.popViewController(animated: true)
    }
    
    func didReportItem() {
        let alertMessage = "User successfully reported."
        alertController.textFields?.first?.text = ""
        
        if let detailView = self.detailView as? ItemDetailView, let currentItem = detailView.title {
            self.alertController.title = "You have successfully reported \(currentItem)."
        }
        
        let messageVC = MessageAlertController(title: "Done", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        messageVC.completion = { self.navigationController?.popViewController(animated: true) }
        present(messageVC, animated: true)
    }
    
    func didFailReportingItem(withError error: Error) {
        var alertMessage = "Could not report item at this time."
        if let errorMessage = (error as? LRError)?.description {
            alertMessage = errorMessage
        }
        alertController.textFields?.first?.text = ""
        let messageVC = MessageAlertController(title: "Error", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        messageVC.completion = { self.navigationController?.popViewController(animated: true) }
        present(messageVC, animated: true)
    }
    
    func didBlockUser() {
        let alertMessage = "User successfully blocked."
        
        if let detailView = self.detailView as? ActivityDetailView, let currentUser = detailView.profilePreview.name {
            self.alertController.title = "You have successfully blocked \(currentUser)."
        }
        
        let messageVC = MessageAlertController(title: "Done", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        messageVC.completion = { self.navigationController?.popViewController(animated: true) }
        present(messageVC, animated: true)
    }
    
    func didFailBlockingUser(withError error: Error) {
        let alertMessage = "User already blocked."
        let messageVC = MessageAlertController(title: "Error", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        present(messageVC, animated: true)
    }
    
    func didReportUser() {
        let alertMessage = "User successfully reported."
        alertController.textFields?.first?.text = ""
        
        if let detailView = self.detailView as? ActivityDetailView, let currentUser = detailView.profilePreview.name {
            self.alertController.title = "You have successfully reported \(currentUser)."
        }
        
        let messageVC = MessageAlertController(title: "Done", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        messageVC.completion = { self.navigationController?.popViewController(animated: true) }
        present(messageVC, animated: true)
    }
    
    func didFailReportingUser(withError error: Error) {
        let alertMessage = "User already reported."
        alertController.textFields?.first?.text = ""
        let messageVC = MessageAlertController(title: "Error", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        messageVC.completion = { self.navigationController?.popViewController(animated: true) }
        present(messageVC, animated: true)
    }
}
