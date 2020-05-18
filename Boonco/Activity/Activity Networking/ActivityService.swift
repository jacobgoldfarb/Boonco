//
//  ActivityService.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-03.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Alamofire

struct ActivityService: ActivityServiceable, ActivityDetailServiceable {
    
    let requestBuilder = RequestBuilder()
    
    //MARK: Activity (Main view)
    
    func getBids(completion: @escaping ([Bid]?, Error?) -> ()) {
        let route = requestBuilder.routes.getBids()
        let headers = requestBuilder.getRequestHeaders()
        AF.request(route, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: headers).responseJSON  { response in
            self.handleGetBidsResponse(response, completion: completion)
        }
    }
    
    //MARK: Activity (Detail view)
    
    func approve(bid: Bid, completion: @escaping (Error?) -> ()) {
        let route = requestBuilder.routes.acceptBid(id: bid.id)
        let headers = requestBuilder.getRequestHeaders()
        AF.request(route, method: .patch, parameters: nil,
                   encoding: URLEncoding.queryString, headers: headers)
            .validate(statusCode: 200..<300).responseJSON   { response in
                switch (response.result) {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
        }
    }
    
    func reject(bid: Bid, completion: @escaping (Error?) -> ()) {
        let route = requestBuilder.routes.rejectBid(id: bid.id)
        let headers = requestBuilder.getRequestHeaders()
        AF.request(route, method: .patch, parameters: nil,
                   encoding: URLEncoding.queryString, headers: headers)
            .validate(statusCode: 200..<300).responseJSON   { response in
                switch (response.result) {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
        }
    }
    
    private func handleGetBidsResponse(_ response: AFDataResponse<Any>, completion: @escaping ([Bid]?, Error?) -> ()) {
        switch(response.result) {
        case .success:
            let bids = try! JSONDecoder().decode([Bid].self, from: response.data!)
            completion(bids, nil)
        case .failure(let error):
            completion(nil, error)
        }
    }
    
    func blockUser(_ blockUserRequest: BlockUserRequest, completion: @escaping (Error?) -> ()) {
        guard let user = AuthState.shared.getUser() else {
            completion(LRError.notAuthenticated)
            return
        }
        
        guard let data = getBlockUserRequestData(from: blockUserRequest) else {
            completion(LRError.encodingError)
            return
        }
        
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! Parameters
        let route = requestBuilder.routes.blockUser(id: user.id)
        let headers = requestBuilder.getRequestHeaders()
        
        AF.request(route, method: .post, parameters: json,
                   encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300).responseJSON   { response in
                switch (response.result) {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
        }
    }
    
    func reportUser(_ reportUserRequest: ReportUserRequest, completion: @escaping (Error?) -> ()) {
        guard let data = getReportUserRequestData(from: reportUserRequest) else {
            completion(LRError.encodingError)
            return
        }
        
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! Parameters
        let route = requestBuilder.routes.reportUser()
        let headers = requestBuilder.getRequestHeaders()
        AF.request(route, method: .post, parameters: json,
                   encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300).responseJSON   { response in
                switch (response.result) {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
        }
    }
    
    //MARK: Helpers
    
    private func getBlockUserRequestData(from request: BlockUserRequest) -> Data? {
        return try? JSONEncoder().encode(request)
    }
    
    private func getReportUserRequestData(from request: ReportUserRequest) -> Data? {
        return try? JSONEncoder().encode(request)
    }
}
