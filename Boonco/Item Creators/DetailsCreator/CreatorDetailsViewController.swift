//
//  CreatorDetailsViewController.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-27.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class CreatorDetailsViewController: CreationFlowViewController {
        
    var creatorView: CreatorDetailsView!
    
    //MARK: Setup
    
    override func loadView() {
        creatorView = getCreatorDetailViewType()
        creatorView.priceComponent.priceEntryTextField.delegate = self
        creatorView.postButton.addTarget(self, action: #selector(didTapPostButton(_:)), for: .touchUpInside)
        view = creatorView
    }
    
    fileprivate func getCreatorDetailViewType() -> CreatorDetailsView {
        return CreatorDetailsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        isLastController = true
        setupNavInterface()
        setupTableViewConnections()
    }

    //MARK: Navigation
    
    func setupNavInterface() {
        setRightBarButtonText(to: "")
    }

    override func handleGoForwards() {
        return
    }
    
    func getPrice(from component: PricePromptView) -> Double? {
        guard let priceComponents = component.priceEntryTextField.text?.split(separator: " "),
            priceComponents.count > 1, let price = Double(priceComponents[1]) else {
                return nil
        }
        return price
    }
    
    func getDuration(from component: DropdownPromptView) -> RentalPeriod {
        return component.selectedPeriod
    }
    
    @objc fileprivate func didTapPostButton(_ sender: PrimaryButton) {
        do {
            try createOffering()
            ProgressView.show()
            viewModel.postNewItem()
        } catch {
            if let error = (error as? LRError) {
                displayErrorMessage(with: error)
            } else {
                print(error)
            }
        }
    }
    
    func createOffering() throws {}
}

// MARK: UITextFieldDelegate

extension CreatorDetailsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textLength = textField.text?.count, textLength < 10 else {
            return false
        }
        
        if textLength == 9 && !string.isEmpty {
            return false
        }
        
        let tooManyPeriods = string.contains(".") && textField.text?.contains(".") ?? false
        let onlyDefaultText = textField.text == "$ "

        if !stringIsValidAmountComponent(string) || tooManyPeriods || (onlyDefaultText && string.isEmpty) ||
            tooManyCentsPlaces(in: textField.text ?? "", range: range) && (range.location >= textLength - 2) {
            return false
        }
        return true
    }
    
    private func stringIsValidAmountComponent(_ string: String) -> Bool {
        return Int(string) != nil || string == "." || string == ""
    }
    
    private func tooManyCentsPlaces(in string: String, range: NSRange) -> Bool {
        let textSections = string.split(separator: ".")
        if textSections.count > 1 && textSections[1].count == 2 && range.length != 1 {
            return true
        }
        return false
    }
}

//MARK: UITableView delegate

extension CreatorDetailsViewController: UITableViewDelegate {
    private func setupTableViewConnections() {
        creatorView.checklistComponent?.checklistTable.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
            }
        }
        print("row at index \(indexPath.row) selected")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}


extension CreatorDetailsViewController: CreatorViewModelDelegate {
    func didCreateOffering() {
        ProgressView.dismiss()
        let messageAC = MessageAlertController(title: "Success", message: "Listing created successfully. You may monitor it in the 'Profile' or 'Activity' tab.", preferredStyle: UIAlertController.Style.alert)
        messageAC.completion = didDismissAlert
        present(messageAC, animated: true)
    }
    
    func displayErrorMessage(with error: LRError) {
        let errorAC = MessageAlertController(title: "Error", message: error.description, preferredStyle: UIAlertController.Style.alert)
        present(errorAC, animated: true)
    }
    
    func didDismissAlert() {
        dismiss(animated: true, completion: nil)
    }
}

class RentalCreatorDetailsViewController: CreatorDetailsViewController {
    override var navigationTitle: String {
        return "Lend Something"
    }
    
    override func createOffering() throws {
        guard let title = creatorView.titleComponent.titleEntryTextField.text, !title.isEmpty else {
            throw LRError.absentTitle
        }
        
        let maxPrice: Double = 9999.99
        guard let price = getPrice(from: creatorView.priceComponent), price <= maxPrice else {
            throw LRError.invalidPrice
        }
        
        let period = getDuration(from: creatorView.dropdownComponent)
        //TODO: customizable rental periods
        //idea: create a nullable textfield defaulted to 1 beside, and unlock it when it's you select custom
        
        let description = creatorView.descriptionComponent.descriptionTextView.text ?? ""
        viewModel.updateRentalDetails(withPrice: price, description: description, title: title, period: period)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatorView.postButtonText = "Create Listing"
    }
}

class RequestCreatorDetailsViewController: CreatorDetailsViewController {
    override var navigationTitle: String {
        return "Borrow Something"
    }
    
    override func createOffering() throws {
        guard let title = creatorView.titleComponent.titleEntryTextField.text, !title.isEmpty else {
            throw LRError.absentTitle
        }
        
        let maxPrice: Double = 9999.99
        guard let price = getPrice(from: creatorView.priceComponent), price <= maxPrice else {
            throw LRError.invalidPrice
        }
        
        let period = getDuration(from: creatorView.dropdownComponent)
        let description = creatorView.descriptionComponent.descriptionTextView.text ?? ""
        viewModel.updateRequestDetails(withPrice: price, description: description, title: title, period: period)
    }
}
