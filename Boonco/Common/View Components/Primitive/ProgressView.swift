//
//  ProgressView.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-29.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation
import SVProgressHUD

struct ProgressView {
    
    static func show() {
        SVProgressHUD.show()
    }
    
    static func dismiss(withDelay delay: TimeInterval? = nil) {
        if let delay = delay {
            SVProgressHUD.dismiss(withDelay: delay)
        } else {
            SVProgressHUD.dismiss()
        }
    }
}
