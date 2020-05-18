//
//  ActivityDetailViewController.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-02.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController {
    
    var viewModel: ActivityDetailViewModel!
    var detailView: ActivityDetailView!
    var alertController: UIAlertController!
    var reportAlertController: UIAlertController!
    
    override func loadView() {
        detailView = ActivityDetailView()
        view = detailView
    }
    
    override func viewDidLoad() {
        viewModel.delegate = self
        setupView()
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailView.updateView()
        detailView.scrollView.flashScrollIndicators()
    }
    
    func setupView() {
        detailView.updateProfilePreview(for: viewModel.bid.status)
        switch viewModel.bid.status {
        case .accepted:
            populateAcceptedProfileView()
            setupActionsForAccepted()
            setupAlertViewController()
            setupReportAlertViewController()
        case .active:
            setupActionsForActive()
            setupAlertViewController()
            setupReportAlertViewController()
        default:
            break
        }
        populateProfileView()
        populateItemView()
    }
    
    func setupActionsForActive() {
        guard let profilePreview = detailView.profilePreview as? ActiveBidProfilePreview else { return }
        profilePreview.additionalOptionsButton.addTarget(self, action: #selector(didPressAdditionalOptions), for: .touchUpInside)
        profilePreview.approveButton.addTarget(self, action: #selector(didPressApprove), for: .touchUpInside)
        profilePreview.rejectButton.addTarget(self, action: #selector(didPressReject), for: .touchUpInside)
    }
    
    func setupActionsForAccepted() {
        guard let profilePreview = detailView.profilePreview as? AcceptedBidProfilePreview else { return }
        profilePreview.additionalOptionsButton.addTarget(self, action: #selector(didPressAdditionalOptions), for: .touchUpInside)
        let contactView: ContactInfoView = profilePreview.contactInfoView
        contactView.phoneNumberButton.addTarget(self, action: #selector(didPressCall(_:)), for: .touchUpInside)
        contactView.emailButton.addTarget(self, action: #selector(didPressEmail(_:)), for: .touchUpInside)
    }
    
    private func populateProfileView() {
        detailView.populateProfileView(from: viewModel.bid.bidder)
    }
    
    private func populateItemView() {
        detailView.populateItemView(from: viewModel.bid.item)
    }
    
    func populateAcceptedProfileView() {
        let user = viewModel.bid.bidder
        detailView.populateAcceptedProfileView(for: user)
    }
    
    @objc private func didPressAdditionalOptions(_ sender: UIButton) {
        showActionSheet()
    }
    
    @objc private func didPressApprove(_ sender: UIButton) {
        viewModel.approveBid()
    }
    
    @objc private func didPressReject(_ sender: UIButton) {
        viewModel.rejectBid()
    }
    
    @objc private func didPressCall(_ sender: UIButton) {
        guard let phoneNumber = viewModel.bid.item.owner.phoneNumber,
            let url = URL(string: "tel://\(phoneNumber)") else { return }
        UIApplication.shared.open(url)
    }
    
    @objc private func didPressEmail(_ sender: UIButton) {
        let email = viewModel.bid.item.owner.email
        guard let url = URL(string: "mailto:\(email)?subject=Interest%20in%20Offering%20%5BAccepted%20Request%5D") else { return }
        UIApplication.shared.open(url)
    }
    
    //MARK: Action sheet and alert view

    private func getActionSheet() -> UIAlertController{
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Report", style: UIAlertAction.Style.destructive) { _ in
            if let currentUser = self.detailView.profilePreview.name {
                self.reportAlertController.title = "Report \(currentUser)?"
            }
            self.present(self.reportAlertController, animated: true)
            //TODO: Add bottom slide up report controller
        })
        
        actionSheet.addAction(UIAlertAction(title: "Block", style: UIAlertAction.Style.destructive) { _ in
            if let currentUser = self.detailView.profilePreview.name {
                self.alertController.title = "Block \(currentUser)?"
            }
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
        let blockUserMessage: String = Theme.standard.strings.blockUserMessage
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let blockAction = UIAlertAction(title: "Block", style: .destructive) { (action: UIAlertAction) in
            self.viewModel.blockUser()
        }

        alertController = UIAlertController(title: "Block user?", message: blockUserMessage, preferredStyle: .alert)
        alertController.addAction(cancelAction)
        alertController.addAction(blockAction)
    }
    
    private func setupReportAlertViewController() {
        let reportUserMessage: String = Theme.standard.strings.reportUserMessage
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let reportAction = UIAlertAction(title: "Report", style: .destructive) { (action: UIAlertAction) in
            let reportedMessage: String = self.reportAlertController.textFields?.first?.text ?? ""
            self.viewModel.reportUser(with: reportedMessage)
        }
        
        reportAlertController = UIAlertController(title: "Report User?", message: reportUserMessage, preferredStyle: .alert)
        reportAlertController.addAction(cancelAction)
        reportAlertController.addAction(reportAction)
        reportAlertController.addTextField { (textfield) in
            textfield.placeholder = "Enter the description"
        }
    }
}

// MARK: ViewModel Delegate

extension ActivityDetailViewController: ActivityDetailViewModelDelegate {
    func didFailApprovingBid(withError error: Error) {
        let messageVC = MessageAlertController(title: "Error", message: "Could not accept offer, please try again later.", preferredStyle: UIAlertController.Style.alert)
        present(messageVC, animated: true)
    }
    
    func didFailRejectingBid(withError error: Error) {
        let messageVC = MessageAlertController(title: "Error", message: "Could not reject offer, please try again later.", preferredStyle: UIAlertController.Style.alert)
        present(messageVC, animated: true)
    }
    
    func didApproveBid() {
        let messageVC = MessageAlertController(title: "Done", message: "You've accepted this offer. The other party will be notified.", preferredStyle: UIAlertController.Style.alert)
        present(messageVC, animated: true)
        setupView()
    }
    
    func didRejectBid() {
        let messageVC = MessageAlertController(title: "Done", message: "You've rejected this offer. It will remain in your activity until you've approved another party in case you change your mind.", preferredStyle: UIAlertController.Style.alert)
        present(messageVC, animated: true)
        setupView()
    }
    
    func didBlockUser() {
        let alertMessage = "User successfully blocked."
        if let currentUser = self.detailView.profilePreview.name {
            self.alertController.title = "You have successfully blocked \(currentUser)."
        }
        let messageVC = MessageAlertController(title: "Done", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        
        messageVC.completion = {
            self.navigationController?.popViewController(animated: true)
        }
        present(messageVC, animated: true)
    }
    
    func didFailBlockingUser(withError error: Error) {
        let alertMessage = "User already blocked."
        let messageVC = MessageAlertController(title: "Error", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        present(messageVC, animated: true)
    }
    
    func didReportUser() {
        let alertMessage = "User successfully reported."
        reportAlertController.textFields?.first?.text = ""
        
        if let currentUser = self.detailView.profilePreview.name {
            self.alertController.title = "You have successfully reported \(currentUser)."
        }
        
        let messageVC = MessageAlertController(title: "Done", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        
        messageVC.completion = {
            self.navigationController?.popViewController(animated: true)
        }
        present(messageVC, animated: true)
    }
    
    func didFailReportingUser(withError error: Error) {
        let alertMessage = "User already reported."
        reportAlertController.textFields?.first?.text = ""
        let messageVC = MessageAlertController(title: "Error", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        messageVC.completion = {
            self.navigationController?.popViewController(animated: true)
        }
        present(messageVC, animated: true)
    }
}
