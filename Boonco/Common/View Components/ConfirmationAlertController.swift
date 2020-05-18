//
//  ConfirmationAlertController.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-25.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class ConfirmationAlertController: UIAlertController {
    
    var confirmCompletion: (() -> ()) = {}
    var cancelCompletion: (() -> ()) = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { _ in
            self.dismiss(animated: true, completion: nil)
            self.confirmCompletion()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
            self.cancelCompletion()
        }
        addAction(confirmAction)
        addAction(cancelAction)
        formatText()
    }
    
    private func formatText() {
        let titleAttributes = [NSAttributedString.Key.font: Theme.standard.font.largeHeader]
        let titleString = NSAttributedString(string: title!, attributes: titleAttributes)
        let messageAttributes = [NSAttributedString.Key.font: Theme.standard.font.regular]
        let messageString = NSAttributedString(string: message!, attributes: messageAttributes)
        setValue(titleString, forKey: "attributedTitle")
        setValue(messageString, forKey: "attributedMessage")
    }
}
