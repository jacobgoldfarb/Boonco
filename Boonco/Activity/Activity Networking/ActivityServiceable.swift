//
//  ActivityServiceable.swift
//  Boonco
//
//  Created by Peter Huang on 2020-05-02.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

protocol ActivityServiceable {
    func getBids(completion: @escaping ([Bid]?, Error?) -> ())
}

protocol ActivityDetailServiceable {
    func approve(bid: Bid, completion: @escaping (Error?) -> ())
    func reject(bid: Bid, completion: @escaping (Error?) -> ())
    func blockUser(_ blockUserRequest: BlockUserRequest, completion: @escaping (Error?) -> ())
    func reportUser(_ reportUserRequest: ReportUserRequest, completion: @escaping (Error?) -> ())
}
