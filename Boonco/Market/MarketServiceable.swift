//
//  MarketServiceable.swift
//  Boonco
//
//  Created by Peter Huang on 2020-05-03.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation
import Alamofire

protocol MarketServiceable {
    func getRentals(forPage page: Int, completion: @escaping ([Item]?, Error?) -> ())
    func getRequests(forPage page: Int, completion: @escaping ([Item]?, Error?) -> ())
    func cancelRequest(bidId: String, completion: @escaping (Error?) -> ())
    func postBid(onItemWithId id: String, completion: @escaping (Bid?, Error?) -> ())
    func deleteItem(withId id: String, completion: @escaping (Error?) -> ())
    func reportItem(_ reportItemRequest: ReportItemRequest, completion: @escaping (Error?) -> ())
    func blockUser(_ blockUserRequest: BlockUserRequest, completion: @escaping (Error?) -> ())
    func reportUser(_ reportUserRequest: ReportUserRequest, completion: @escaping (Error?) -> ())
}
