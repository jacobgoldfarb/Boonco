//
//  MarketService.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-03.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Alamofire

struct MarketService: MarketServiceable {
    
    let requestBuilder = RequestBuilder()
    
    func getRentals(forPage page: Int, completion: @escaping ([Item]?, Error?) -> ()) {
        let route = requestBuilder.routes.getRentals()
        var params = requestBuilder.addGeoDataToRequest(inParams: [:])
        params = requestBuilder.addPageToRequest(page: page, inParams: params)
        let headers = requestBuilder.getRequestHeaders()
        AF.request(route, method: .get, parameters: params,
                   encoding: URLEncoding.queryString, headers: headers).validate(statusCode: 200..<300).responseJSON  { response in
                    self.handleItemsResponse(response, type: .rental, completion: completion)
        }
    }
    
    func getRequests(forPage page: Int, completion: @escaping ([Item]?, Error?) -> ()) {
        let route = requestBuilder.routes.getRequests()
        var params = requestBuilder.addGeoDataToRequest(inParams: [:])
        params = requestBuilder.addPageToRequest(page: page, inParams: params)
        let headers = requestBuilder.getRequestHeaders()
        AF.request(route, method: .get, parameters: params,
                   encoding: URLEncoding.queryString, headers: headers).validate(statusCode: 200..<300).responseJSON  { response in
                    self.handleItemsResponse(response, type: .request, completion: completion)
        }
    }
    
    func cancelRequest(bidId: String, completion: @escaping (Error?) -> ()) {
        let route = requestBuilder.routes.deleteBid(id: bidId)
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
    
    func postBid(onItemWithId id: String, completion: @escaping (Bid?, Error?) -> ()) {
        let route = requestBuilder.routes.postBid(itemId: id)
        let headers = requestBuilder.getRequestHeaders()
        AF.request(route, method: .post, parameters: nil,
                   encoding: URLEncoding.queryString, headers: headers)
            .validate(statusCode: 200..<300).responseJSON   { response in
                switch(response.result) {
                case .success:
                    let bid = try! JSONDecoder().decode(Bid.self, from: response.data!)
                    completion(bid, nil)
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
    
    func deleteItem(withId id: String, completion: @escaping (Error?) -> ()) {
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
        case .success(let json):
            if Theme.standard.debug {
                debugPrint(json)
            }
            var items: [Item] = [Item]()
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if type == .rental {
                items = try! decoder.decode([Rental].self, from: response.data!)
            } else if type == .request {
                items = try! decoder.decode([Request].self, from: response.data!)
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
    
    func reportItem(_ reportItemRequest: ReportItemRequest, completion: @escaping (Error?) -> ()) {
        guard let data = getReportItemRequestData(from: reportItemRequest) else {
            completion(LRError.encodingError)
            return
        }
        
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! Parameters
        let route = requestBuilder.routes.reportItem()
        let headers = requestBuilder.getRequestHeaders()
        AF.request(route, method: .post, parameters: json,
                   encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300).responseJSON   { response in
                switch (response.result) {
                case .success:
                    completion(nil)
                case .failure(let error):
                    // TODO: Figure out why response code is 500 despite backend returning 422
                    if let code = response.response?.statusCode,
                        code == 500 || code == 422 {
                        completion(LRError.actionAlreadyDone)
                        return
                    }
                    completion(error)
                }
        }
    }
    
    //TODO: backend gate blocking the same user twice
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
                    if error.responseCode == 422 {
                        completion(LRError.actionAlreadyDone)
                        return
                    }
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
    
    private func getReportItemRequestData(from request: ReportItemRequest) -> Data? {
        return try? JSONEncoder().encode(request)
    }
    
    private func getBlockUserRequestData(from request: BlockUserRequest) -> Data? {
        return try? JSONEncoder().encode(request)
    }
    
    private func getReportUserRequestData(from request: ReportUserRequest) -> Data? {
        return try? JSONEncoder().encode(request)
    }
}
