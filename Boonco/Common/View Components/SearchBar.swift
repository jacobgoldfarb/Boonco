//
//  SearchBar
//  Lender
//
//  Created by Peter Huang on 2020-04-07.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class SearchBar: UISearchBar {
    
    var searchBarPlaceholder = "Search items..."

    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            for view : UIView in (self.subviews[0]).subviews {
                if let textField = view as? UITextField {
                    return textField
                }
            }
        }
        return nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchBar() {
        if #available(iOS 13.0, *) {
            searchTextField.textColor = .white
            searchTextField.attributedPlaceholder =
                NSAttributedString(string: searchBarPlaceholder,
                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            searchTextField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.12)
            (searchTextField.leftView as? UIImageView)?.tintColor = .white
        } else {
            placeholder = searchBarPlaceholder
            textField?.textColor = .white
            textField?.attributedPlaceholder =
            NSAttributedString(string: searchBarPlaceholder,
                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            textField?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.12)
            (textField?.leftView as? UIImageView)?.tintColor = .white
        }
    }
}
