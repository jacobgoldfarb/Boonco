//
//  ReportUserRequest.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-29.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

struct ReportUserRequest: Encodable {
    let reportedById: String
    let reporteeId: String
    let message: String?
    
    public enum ReportUserRequestCodingKeys: String, CodingKey {
        case reportedById = "reported_by_id"
        case reporteeId = "reportee_id"
        case message = "message"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ReportUserRequestCodingKeys.self)
        try container.encode(reportedById, forKey: .reportedById)
        try container.encode(reporteeId, forKey: .reporteeId)
        try container.encode(message, forKey: .message)
    }
}
