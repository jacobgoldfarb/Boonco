//
// Created by Jacob Goldfarb on 2020-03-29.
// Copyright (c) 2020 Project PJ. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    var viewModel: ItemDetailViewModel!
    var detailView: ItemDetailView!
    var alertController: UIAlertController!
    
    override func loadView() {
        detailView = ItemDetailView()
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchItemImage()
        populateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.fetchItemImage()
    }

    private func populateView() {
        populateView(detailView)
        formatNavBarClear()
    }
    
    private func populateView(_ itemDetailView: ItemDetailView) {
        itemDetailView.populateView(from: viewModel.item)
        itemDetailView.actionButton.addTarget(self, action: #selector(didPressItemAction), for: .touchUpInside)
        itemDetailView.additionalOptionsButton.addTarget(self, action: #selector(didPressAdditionalOptions), for: .touchUpInside)
        setupAlertViewController()
        updateView(itemDetailView, for: viewModel.item)
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
        
    @objc private func didPressItemAction(_ sender: UIButton) {
        guard AuthState.shared.getUser() != nil else {
            tabBarController?.navigationController?.popToRootViewController(animated: true)
            return
        }
        viewModel.didPressItemAction()
    }
    
    @objc private func didPressAdditionalOptions(_ sender: UIButton) {
        showActionSheet()
    }
    
    //MARK: Action sheet and alert view
    
    private func getActionSheet() -> UIAlertController {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Report", style: UIAlertAction.Style.destructive) { _ in
            self.present(self.alertController, animated: true)
        })
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel))
        return actionSheet
    }
    
    private func showActionSheet() {
        let actionSheet = getActionSheet()
        present(actionSheet, animated: true)
    }
    
    private func setupAlertViewController() {
        let alertMessage: String = Theme.standard.strings.reportItemMessage
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let reportAction = UIAlertAction(title: "Report", style: .destructive) { (action: UIAlertAction) in
            let reportedMessage: String = self.alertController.textFields?.first?.text ?? ""
            self.viewModel.reportItem(with: reportedMessage)
        }

        alertController = UIAlertController(title: "Report this post?", message: alertMessage, preferredStyle: .alert)
        alertController.addAction(reportAction)
        alertController.addAction(cancelAction)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Enter the description"
        }
    }
}

extension ItemDetailViewController: ItemDetailViewModelDelegate {
    func didRequestItemDeletion() {
        let confirmVC = ConfirmationAlertController(title: "Are you sure?", message: "This item will be removed from the marketplace.", preferredStyle: UIAlertController.Style.alert)
        confirmVC.confirmCompletion = viewModel.deleteItem
        present(confirmVC, animated: true)
    }
    
    func didRequestBidDeletion() {
        let confirmVC = ConfirmationAlertController(title: "Are you sure?", message: "You request will be revoked.", preferredStyle: UIAlertController.Style.alert)
        confirmVC.confirmCompletion = viewModel.deleteBid
        present(confirmVC, animated: true)
    }
    
    func didFinishRequesting(item: Item) {
        updateView(view as! ItemDetailView, for: item)
        let messageVC = MessageAlertController(title: "Success", message: "You can monitor this item in the 'Activity' tab.", preferredStyle: UIAlertController.Style.alert)
        present(messageVC, animated: true)
    }
    
    func didFailRequesting(item: Item, withError error: Error) {
        
    }
    
    func didFinishDownloadingImage(_ image: UIImage) {
        detailView.image = image
    }
    
    func didFinishCancelingRequest(for item: Item) {
        updateView(view as! ItemDetailView, for: item)
        print("Did finish canceling item")
    }
    
    func didFinishDeletingItem() {
        navigationController?.popViewController(animated: true)
    }
    
    func didReportItem() {
        let alertMessage = "Item successfully reported."
        alertController.textFields?.first?.text = ""
        
        if let currentItem = self.detailView.title {
            self.alertController.title = "You have successfully reported \(currentItem)."
        }
        
        let messageVC = MessageAlertController(title: "Done", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        
        messageVC.completion = {
            self.navigationController?.popViewController(animated: true)
        }
        present(messageVC, animated: true)
    }
    
    func didFailReportingItem(withError error: Error) {
        var alertMessage = "Could not report item at this time."
        if let errorMessage = (error as? LRError)?.description {
            alertMessage = errorMessage
        }
        alertController.textFields?.first?.text = ""
        let messageVC = MessageAlertController(title: "Error", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        messageVC.completion = {
            self.navigationController?.popViewController(animated: true)
        }
        present(messageVC, animated: true)
    }
}

// MARK: Subclasses

class RentalItemDetailViewController: ItemDetailViewController {
    override func loadView() {
        detailView = ListingItemDetailView()
        view = detailView
    }
}

class RequestItemDetailViewController: ItemDetailViewController {
    override func loadView() {
        detailView = RequestItemDetailView()
        view = detailView
    }
}
