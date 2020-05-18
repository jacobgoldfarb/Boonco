//
//  AuthenticationServiceable.swift
//  Boonco
//
//  Created by Jacob Goldfarb on 2020-04-30.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

protocol AuthenticationServiceable {
    func signUp(withCreds creds: SignUpCredentials, completion: @escaping (Error?, User?) -> ())
    func logIn(withCreds creds: Login, completion: @escaping (Error?) -> ())
}
