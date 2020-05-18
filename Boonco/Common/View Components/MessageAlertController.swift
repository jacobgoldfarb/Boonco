//
//  MessageAlertController.swift
//  Alamofire
//
//  Created by Jacob Goldfarb on 2020-04-16.
//

import UIKit

class MessageAlertController: UIAlertController {
    
    var completion: (() -> ())? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dismissAction = UIAlertAction(title: "Ok", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
            if let completion = self.completion {
                completion()
            }
        }
        addAction(dismissAction)
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
