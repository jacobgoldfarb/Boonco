//
//  ProfileService.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-17.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Alamofire

struct ProfileService {
    
    let requestBuilder = RequestBuilder()
    
    func getRentals(completion: @escaping ([Item]?, Error?) -> ()) {
        guard let currentUser = AuthState.shared.getUser() else { return }
        let route = requestBuilder.routes.getUserRentals(userId: currentUser.id)
        let headers = requestBuilder.getRequestHeaders()
        AF.request(route, method: .get, parameters: nil,
                   encoding: URLEncoding.queryString, headers: headers).validate(statusCode: 200..<300).responseJSON  { response in
                    self.handleItemsResponse(response, type: .rental, completion: completion)
        }
    }
    
    func getRequests(completion: @escaping ([Item]?, Error?) -> ()) {
        guard let currentUser = AuthState.shared.getUser() else { return }
        let route = requestBuilder.routes.getUserRequests(userId: currentUser.id)
        let headers = requestBuilder.getRequestHeaders()
        AF.request(route, method: .get, parameters: nil,
                   encoding: URLEncoding.queryString, headers: headers).validate(statusCode: 200..<300).responseJSON  { response in
                    self.handleItemsResponse(response, type: .request, completion: completion)
        }
    }
    
    func updateUser(_ user: User, completion: @escaping (User?, Error?) -> ()) {
        let route = requestBuilder.routes.updateUser(id: user.id)
        let headers = requestBuilder.getRequestHeaders()
        let data = try! JSONEncoder().encode(user)
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! Parameters
        AF.request(route, method: .put, parameters: json,
                   encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300).responseJSON   { response in
                switch (response.result) {
                case .success:
                    let user = try! JSONDecoder().decode(User.self, from: response.data!)
                    AuthState.shared.setUser(user)
                    completion(user, nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
    
    func postPhoto(_ image: UIImage, completion: @escaping (Error?) -> ()) {
        guard let user = AuthState.shared.getUser() else {
            completion(LRError.notAuthenticated)
            return
        }
        let imgData = image.jpegData(compressionQuality: 0.2)!
        let encodedImage = imgData.base64EncodedString()
        let params = ["profile_picture": encodedImage]
        let route = requestBuilder.routes.postProfilePicture(forUserWithId: user.id)
        let header = requestBuilder.getRequestHeaders()
        
        AF.request(route, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON  { response in
            completion(nil)
            return
        }
    }
    
    func cancelItem(withId id: String, completion: @escaping (Error?) -> ()) {
        let route = requestBuilder.routes.deleteItem(id: id)
        let headers = requestBuilder.getRequestHeaders()
        AF.request(route, method: .delete, parameters: nil,
                   encoding: URLEncoding.queryString, headers: headers)
            .validate(statusCode: 200..<300).responseJSON   { response in
                switch(response.result) {
                case .success:
                    completion(nil)
                case .failure(let error):
                    if let httpStatusCode = response.response?.statusCode {
                        switch(httpStatusCode) {
                        case 401:
                            completion(LRError.notAuthenticated)
                        default:
                            completion(error)
                        }
                    } else {
                        completion(error)
                    }
                }
        }
    }
    
    func handleItemsResponse(_ response: AFDataResponse<Any>, type: ItemType, completion: @escaping ([Item]?, Error?) -> ()) {
        switch(response.result) {
        case .success:
            var items: [Item] = [Item]()
            if type == .rental {
                items = try! JSONDecoder().decode([Rental].self, from: response.data!)
            } else if type == .request {
                items = try! JSONDecoder().decode([Request].self, from: response.data!)
            }
            completion(items, nil)
        case .failure(let error):
            if let httpStatusCode = response.response?.statusCode {
                switch(httpStatusCode) {
                case 401:
                    completion(nil, LRError.notAuthenticated)
                default:
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
}
