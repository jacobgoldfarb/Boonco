//
//  EntranceTests.swift
//  BooncoTests
//
//  Created by Jacob Goldfarb on 2020-04-30.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import XCTest
@testable import Boonco

class SignUpTests: XCTestCase {
    
    let entranceDelegate = MockEntranceViewModelDelegate()
    var signUpVM: SignUpViewModel!
    var validCreds: SignUpCredentials = DataGenerator.generateSignUpCreds()
    
    override func setUp() {
        signUpVM = SignUpViewModel(authService: MockAuthenticationService())
        signUpVM.signUpDelegate = entranceDelegate
    }

    func testValidSignUp() throws {
        signUpVM.signUpCredentials = validCreds
        signUpVM.signUp()
        XCTAssertTrue(entranceDelegate.signUpDidSucceedCalled)
        XCTAssertFalse(entranceDelegate.signUpDidFailCalled)
    }
    
    func testInvalidEmailSignUp() throws {
        var invalidCreds = validCreds
        invalidCreds.email = "invalid_email.com"
        signUpVM.signUpCredentials = invalidCreds
        signUpVM.signUp()
        XCTAssertFalse(entranceDelegate.signUpDidSucceedCalled)
        XCTAssertTrue(entranceDelegate.signUpDidFailCalled)
    }
    
    func testMissingFirstNameSignUp() throws {
        var invalidCreds = validCreds
        invalidCreds.firstName = ""
        signUpVM.signUpCredentials = invalidCreds
        signUpVM.signUp()
        XCTAssertFalse(entranceDelegate.signUpDidSucceedCalled)
        XCTAssertTrue(entranceDelegate.signUpDidFailCalled)
    }
    
    func testPasswordTooShortSignUp() throws {
        var invalidCreds = validCreds
        invalidCreds.password = "1234567"
        signUpVM.signUpCredentials = invalidCreds
        signUpVM.signUp()
        XCTAssertFalse(entranceDelegate.signUpDidSucceedCalled)
        XCTAssertTrue(entranceDelegate.signUpDidFailCalled)
    }
}
