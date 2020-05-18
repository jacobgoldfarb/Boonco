//
//  AuthStateService.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-13.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Alamofire

struct AuthStateService {
    
    let requestBuilder = RequestBuilder()
    
    func checkAuth(token: String, completion: @escaping (Error?, String?, User?) -> ()) {
        let route = requestBuilder.routes.checkAuth()
        let headers = requestBuilder.getRequestHeaders(withToken: token)
        AF.request(route, method: .get,
                   parameters: nil,
                   encoding: URLEncoding.queryString,
                   headers: headers).validate(statusCode: 200..<300).responseJSON  { response in
                    self.handleResponse(response, completion: completion)
        }
    }
    
    func handleResponse(_ response: AFDataResponse<Any>, completion: @escaping (Error?, String?, User?) -> ()) {
        switch(response.result) {
        case .success(let JSON):
            guard let token = (JSON as! [String: Any])["token"],
                let userJSON = (JSON as! [String: Any])["user"] else {
                    completion(LRError.general, nil, nil)
                    return
            }
            let userData = try? JSONSerialization.data(withJSONObject: userJSON)
            let user = try! JSONDecoder().decode(User.self, from: userData!)
            completion(nil, token as? String, user ) // Refreshed token
            return
        case .failure(let error):
            debugPrint(response)
            completion(error, nil, nil)
        }
    }
}
