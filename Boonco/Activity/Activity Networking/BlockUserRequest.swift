//
//  BlockUserRequest.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-28.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

struct BlockUserRequest: Encodable {
    let blockedUserId: String
    let blockedById: String
    
    public enum BlockUserRequestCodingKeys: String, CodingKey {
        case blockedUserId = "blocked_user_id"
        case blockedById = "blocked_by_id"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: BlockUserRequestCodingKeys.self)
        try container.encode(blockedUserId, forKey: .blockedUserId)
        try container.encode(blockedById, forKey: .blockedById)
    }
}
