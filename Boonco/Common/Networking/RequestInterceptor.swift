
//
//  Request Interceptor.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-09.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Alamofire

/// The storage containing your access token, preferable a Keychain wrapper.
protocol AccessTokenStorage: class {
    typealias JWT = String
    var accessToken: JWT { get set }
}

final class RequestInterceptor: Alamofire.RequestInterceptor {
//    let session: Session
    let storage: AccessTokenStorage
    
     init(storage: AccessTokenStorage) {
         self.storage = storage
     }

     func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
         guard urlRequest.url?.absoluteString.hasPrefix("https://api.authenticated.com") == true else {
             /// If the request requires authentication, we can directly return it as unmodified.
             return completion(.success(urlRequest))
         }
         var urlRequest = urlRequest

         /// Set the Authorization header value using the access token.
         urlRequest.setValue("Bearer " + storage.accessToken, forHTTPHeaderField: "Authorization")

         completion(.success(urlRequest))
     }

    func retry(_ request: Alamofire.Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
             /// The request did not fail due to a 401 Unauthorized response.
             /// Return the original error and don't retry the request.
             return completion(.doNotRetryWithError(error))
         }

         refreshToken { [weak self] result in
             guard let self = self else { return }

             switch result {
             case .success(let token):
                self.storage.accessToken = token as! String
                 /// After updating the token we can safily retry the original request.
                 completion(.retry)
             case .failure(let error):
                 completion(.doNotRetryWithError(error))
             }
         }
     }
    
    func refreshToken(_ completion: (Result<Any, Error>) -> ()) {
        
    }
}
