//
//  CreationFlowViewController.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-30.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class CreationFlowViewController: UIViewController {

    var navigationTitle: String {
        return ""
    }
    private var defaultProceedText: String {
        return "Next"
    }
    private var defaultBackText: String {
        return "Back"
    }
    var nextVC: CreationFlowViewController? {
        return nil
    }
    var isFirstController = false
    var isLastController = false
    var viewModel: CreatorViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationItem.title = navigationTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: defaultBackText, style: .plain, target: self, action: #selector(goBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: defaultProceedText, style: .done, target: self, action: #selector(goForwards))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes(Theme.standard.rightBarButtonStyle, for: .normal)
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(Theme.standard.rightBarButtonStyle, for: .normal)
    }
    
    @objc private func goBack(_ sender: UIBarButtonItem) {
        handleGoBack()
    }
    
    @objc private func goForwards(_ sender: UIBarButtonItem) {
        handleGoForwards()
    }
    
    func setRightBarButtonText(to text: String) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: text, style: .done, target: self, action: #selector(goForwards))
    }
    
    func setLeftBarButtonToCancel() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(goBack))
    }
    
    func handleGoBack() {
        if isFirstController {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func handleGoForwards() {
        guard !isLastController else { return }
        guard let nextVC = nextVC else { return }
        nextVC.viewModel = viewModel
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
