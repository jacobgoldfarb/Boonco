//
//  MockAuthenticationService.swift
//  BooncoTests
//
//  Created by Jacob Goldfarb on 2020-04-30.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation
@testable import Boonco

struct MockAuthenticationService: AuthenticationServiceable {
    func signUp(withCreds creds: SignUpCredentials, completion: @escaping (Error?, User?) -> ()) {
        completion(nil, DataGenerator.generateFakeUser())
    }
    
    func logIn(withCreds creds: Login, completion: @escaping (Error?) -> ()) {
        completion(nil)
    }
}

class MockEntranceViewModelDelegate: LogInViewModelDelegate, SignUpViewModelDelegate {
    
    var loginCalled = false
    var loginFailedCalled = false
    var signUpDidSucceedCalled = false
    var signUpDidFailCalled = false
    var didUpdateAddressCalled = false
    
    func logInDidSucceed() {
        loginCalled = true
    }
    
    func logInDidFail(withError error: Error) {
        loginFailedCalled = true
    }
    
    func signUpDidSucceed() {
        signUpDidSucceedCalled = true
    }
    
    func signUpDidFail(withError error: Error) {
        signUpDidFailCalled = true
    }
    
    func didUpdateAddress(_ address: String) {
        didUpdateAddressCalled = true
    }
}
