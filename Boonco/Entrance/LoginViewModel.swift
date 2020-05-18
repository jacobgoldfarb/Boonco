//
//  LogInViewModel.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-25.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation
import CoreLocation

protocol LogInViewModelDelegate {
    func logInDidSucceed()
    func logInDidFail(withError error: Error)
}


struct LoginViewModel {
    
    var delegate: LogInViewModelDelegate!
    let authService: AuthenticationServiceable
    
    
    func logIn(withEmail email: String, password: String) throws {
        let login = Login(email: email, password: password)
        authService.logIn(withCreds: login) { error  in
            guard error == nil else {
                self.delegate.logInDidFail(withError: error!)
                return
            }
            self.delegate.logInDidSucceed()
        }
    }
}
