//
//  Routes.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-09.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Alamofire

struct Environment {
    private static let local = "http://localhost:3000/"
    private static var localDevice: String {
      return "http://\(ngrokHash).ngrok.io/"
    }
    private static let production = "http://api.boonco.ca/"
    
    static var current: String {
        return production
    }
    
    private static let ngrokHash = "35df916e"

}

public enum RouteError: Error {
    case InvalidURL
}

struct Routes {
    let environment: String = Environment.current
    
    /// GET    /users/:user_id/items
    func getUserItems(userId: String) -> String {
        return environment + "users/\(userId)/items"
    }
    
    /// GET    /users/:user_id/items/rentals
    func getUserRentals(userId: String) -> String {
        return environment + "users/\(userId)/items/rentals"
    }
    
    /// GET    /users/:user_id/items/requests
    func getUserRequests(userId: String) -> String {
        return environment + "users/\(userId)/items/requests"
    }
    
    /// GET    /users/:user_id/items/:id
    func getUserItem(userId: String, itemId: String) -> String {
        return environment + "users/\(userId)/items/\(itemId)"
    }
    
    /// PATCH    /users/:id
    func updateUser(id: String) -> String {
        return environment + "users/\(id)"
    }
    
    /// POST    /auth/login
    func login() -> String {
        return environment + "auth/login"
    }
    
    /// POST    /signup
    func signUp() -> String {
        return environment + "signup"
    }
    
    /// GET /auth
    func checkAuth() -> String {
        return environment + "auth"
    }
    
    /// GET    /items
    func getItems() -> String {
        return environment + "items"
    }
    
    /// GET    /items/rentals
    func getRentals() -> String {
        return environment + "items/rentals"
    }
    
    /// GET    /items/requests
    func getRequests() -> String {
        return environment + "items/requests"
    }
    
    /// POST    /items
    func postItem() -> String {
        return environment + "items"
    }
    
    /// POST    /users/:user_id/photo
    func postProfilePicture(forUserWithId id: String) -> String {
        return environment + "users/\(id)/photo"
    }
    
    /// POST    /items
    func postItemPhoto(itemId: String) -> String {
        return environment + "items/\(itemId)/photos"
    }
    
    /// GET    /items/:id
    func getItem(id: String) -> String {
        return environment + "items/\(id)"
    }
    
    /// PATCH    /items/:id
    func updateItem(id: String) -> String {
        return environment + "items/\(id)"
    }
    
    /// DELETE    /items/:id
    func deleteItem(id: String) -> String {
        return environment + "items/\(id)"
    }

    /// GET    /bids
    func getBids() -> String {
        return environment + "bids"
    }
    
    /// POST    /bids
    func postBid(itemId: String) -> String {
        let query = "?" + "item_id" + "=" + itemId
        return environment + "bids" + query
    }
    
    /// DELETE    /bids/:id
    func deleteBid(id: String) -> String {
        return environment + "bids/\(id)"
    }
    
    /// PATCH    /bids/:id/accept
    func acceptBid(id: String) -> String {
        return environment + "bids/\(id)/accept"
    }
    
    /// PATCH    /bids/:id/reject
    func rejectBid(id: String) -> String {
        return environment + "bids/\(id)/reject"
    }
    
    /// POST /reports/item
    func reportItem() -> String {
        return environment + "reports/item"
    }
    
    /// POST /reports/user
    func reportUser() -> String {
        return environment + "reports/user"
    }
    
    /// POST /users/:id/block
    func blockUser(id: String) -> String {
        return environment + "users/\(id)/block"
    }
}
