//
//  RequestBuilder.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-12.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Alamofire

enum APIVersion: String {
    case v1 = "v1"
}

struct RequestBuilder {
    
    let routes = Routes()
    let apiVersion: APIVersion = .v1
    private var jwtToken: String? {
        return AuthState.shared.authToken
    }
    
    /// Authorized token if available
    func getRequestHeaders() -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/vnd.lender.\(apiVersion.rawValue)+json"]
        guard let jwt = jwtToken else {
            return headers
        }
        headers["Authorization"] = "Bearer \(jwt)"
        return headers
    }
    
    /// Explicitly pass in token
    func getRequestHeaders(withToken token: String) -> HTTPHeaders {
        return [
        "Content-Type": "application/json",
        "Accept": "application/vnd.lender.\(apiVersion.rawValue)+json",
            "Authorization": "Bearer \(token)"
        ]
    }
    
    func addGeoDataToRequest(inParams: Parameters) -> Parameters {
        var newParams = inParams
            if let coords = LocationManager.shared.lastLocation?.coordinate {
                newParams["geo_lat"] = coords.latitude
                newParams["geo_long"] = coords.longitude
            }
        return newParams
    }
    
    func addPageToRequest(page: Int, inParams: Parameters) -> Parameters {
        var newParams = inParams
        newParams["page_number"] = page
        return newParams
    }
}
