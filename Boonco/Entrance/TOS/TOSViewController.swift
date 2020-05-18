//
//  TOSViewController.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-29.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class TOSViewController: UIViewController {
    
    var scrolledToBottom: Bool = false {
        didSet {
            if oldValue != scrolledToBottom {
                updateButtons(for: scrolledToBottom)
            }
        }
    }
    
    let tosView: TOSView = TOSView()
    
    override func loadView() {
        tosView.termsText.text = TOSString().TOS
        tosView.termsText.delegate = self
        tosView.agreeButton.addTarget(self, action: #selector(tappedAgree), for: .touchUpInside)
        tosView.declineButton.addTarget(self, action: #selector(tappedDecline), for: .touchUpInside)
        view = tosView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateButtons(for scrolledToBottom: Bool) {
        if scrolledToBottom {
            tosView.agreeButton.backgroundColor = Theme.standard.colors.secondary
        }
    }
    
    @objc func tappedAgree() {
        guard scrolledToBottom else { return }
        AuthState.shared.agreeToTOS()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func tappedDecline() {
        dismiss(animated: true, completion: nil)
    }
}

extension TOSViewController: UITextViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height) {
            scrolledToBottom = true
        }
    }
}

