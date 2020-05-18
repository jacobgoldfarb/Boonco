//
//  ReportItemRequest.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-29.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

struct ReportItemRequest: Encodable {
    let reportedById: String
    let itemId: String
    let message: String?
    
    public enum ReportItemRequestCodingKeys: String, CodingKey {
        case reportedById = "reported_by_id"
        case itemId = "item_id"
        case message = "message"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ReportItemRequestCodingKeys.self)
        try container.encode(reportedById, forKey: .reportedById)
        try container.encode(itemId, forKey: .itemId)
        try container.encode(message, forKey: .message)
    }
}
