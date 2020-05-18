//
//  AuthenticatedUser.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-03.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation
import Alamofire

protocol AuthStateDelegate {
    
    func didSetUser(_ user: User)
    func deauthorizeUser()
}

class AuthState {
    static var shared = AuthState()
    private var authStateService = AuthStateService()
    
    var delegate: AuthStateDelegate?
    private var _user: User?
    private var _authToken: String?
    
    var authToken: String? {
        get {
            if _authToken == nil {
                let token = KeyChain.getToken()
                _authToken = token
                return _authToken
            } else {
                return _authToken
            }
        }
    }
    
    private init() {}
    
    func setUser(_ user: User) {
        _user = user
    }
    
    func getUser() -> User? {
        return _user
    }
    
    func logOut() {
        _user = nil
        _authToken = nil
        KeyChain.deleteToken()
    }
        
    func retrieveToken() throws {
        guard let token = KeyChain.getToken() else {
            throw LRError.notAuthenticated
        }
        _authToken = token
    }
    
    func storeToken(_ token: String) {
        KeyChain.deleteToken()
        KeyChain.storeToken(token)
        _authToken = token
    }
    
    func checkAuth() {
        guard let token = authToken else {
            return
        }
        authStateService.checkAuth(token: String(token)) { error, newToken, user in
            guard error == nil else {
                KeyChain.deleteToken()
                self.delegate?.deauthorizeUser()
                return
            }
            guard let newToken = newToken,
                let user = user else { return }
            self._user = user
            self.delegate?.didSetUser(user)
            self._authToken = newToken
            KeyChain.storeToken(newToken)
        }
    }
    
    func agreedToTOS() -> Bool {
        let agreedToTOSFlag = "agreedToTOSFlag"
        let agreedToTOS = UserDefaults.standard.bool(forKey: agreedToTOSFlag)
        if (agreedToTOS) {
            UserDefaults.standard.set(true, forKey: agreedToTOSFlag)
            UserDefaults.standard.synchronize()
        }
        return agreedToTOS
    }
    
    func agreeToTOS() {
        let agreedToTOSFlag = "agreedToTOSFlag"
        UserDefaults.standard.set(true, forKey: agreedToTOSFlag)
    }
}
