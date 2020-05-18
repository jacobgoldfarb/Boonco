//
//  AuthenticationService.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-25.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation
import Alamofire

struct AuthenticationService: AuthenticationServiceable {
    
    let requestBuilder = RequestBuilder()

    func signUp(withCreds creds: SignUpCredentials, completion: @escaping (Error?, User?) -> ()) {
        let route = requestBuilder.routes.signUp()
        let params = getSignUpParams(fromCreds: creds)
        let headers = requestBuilder.getRequestHeaders()
        AF.request(route, method: .post,
                   parameters: params,
                   encoding: URLEncoding.queryString,
                   headers: headers).validate(statusCode: 200..<300).responseJSON  { response in
                    self.handleSignUpResponse(response, completion: completion)
        }
    }
    
    func logIn(withCreds creds: Login, completion: @escaping (Error?) -> ()) {
        let route = requestBuilder.routes.login()
        let params = getLoginParams(fromCreds: creds)
        let headers = requestBuilder.getRequestHeaders()
        AF.request(route, method: .post,
                   parameters: params,
                   encoding: URLEncoding.queryString,
                   headers: headers).validate(statusCode: 200..<300).responseJSON  { response in
                    self.handleLogInResponse(response, completion: completion)
        }
    }
    
    private func handleSignUpResponse(_ response: AFDataResponse<Any>, completion: @escaping (Error?, User?) -> ()) {
        switch(response.result) {
        case .success(let JSON):
            guard let dict = (JSON as? [String: Any]),
                let token = dict["token"],
                let userJSON = dict["user"],
                let userData = try? JSONSerialization.data(withJSONObject: userJSON),
                let user = try? JSONDecoder().decode(User.self, from: userData) else {
                    return
            }
            AuthState.shared.storeToken(token as! String)
            AuthState.shared.setUser(user)
            completion(nil, user)
        case .failure(let error):
            if let httpStatusCode = response.response?.statusCode {
                switch(httpStatusCode) {
                case 401:
                    completion(LRError.emailTaken, nil)
                default:
                    completion(error, nil)
                }
            } else {
                completion(error, nil)
            }
        }
    }
    
    
    private func handleLogInResponse(_ response: AFDataResponse<Any>, completion: @escaping (Error?) -> ()) {
        switch(response.result) {
        case .success(let JSON):
            guard let dict = (JSON as? [String: Any]),
                let token = dict["token"],
                let userJSON = dict["user"],
                let userData = try? JSONSerialization.data(withJSONObject: userJSON),
                let user = try? JSONDecoder().decode(User.self, from: userData) else {
                    return
            }
            AuthState.shared.storeToken(token as! String)
            AuthState.shared.setUser(user)
            completion(nil)
        case .failure(let error):
            if let httpStatusCode = response.response?.statusCode {
                switch(httpStatusCode) {
                case 401:
                    completion(LRError.wrongCredentials)
                default:
                    completion(error)
                }
            } else {
                completion(error)
            }
        }
    }
    
    private func getSignUpParams(fromCreds creds: SignUpCredentials) -> Parameters {
        return [
            "first_name": creds.firstName,
            "last_name": creds.lastName,
            "email": creds.email,
            "password": creds.password,
            "geo_lat": creds.latitude,
            "geo_long": creds.longitude,
            "address_street": creds.street,
            "address_city": creds.city,
            "address_subnation": creds.subNation,
            "country": creds.country
        ]
    }
    
    private func getLoginParams(fromCreds creds: Login) -> Parameters {
        return [
            "email": creds.email,
            "password": creds.password
        ]
    }
}


