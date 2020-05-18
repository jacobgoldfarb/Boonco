//
//  ProfileViewModel.swift
//  Lender
//
//  Created by Peter Huang on 2020-03-31.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation
import UIKit.UIImage

///Listings: Post a listing of an item you own that you want to lend out
///Requests: Post a request for an item you need that you want to borrow

protocol ProfileViewModelDelegate {
    func didUpdateProfilePicture(forUser user: User)
    func didUpdateProfile(forUser user: User)
    func didGetRentals()
    func didGetRequests()
    func didDownloadProfilePicture(_ image: UIImage)
}

class ProfileViewModel {
    
    let profileService = ProfileService()
    var currentSegmentView: ProfileSegment = .listings
    let delegate: ProfileViewModelDelegate
        
    var myListings: [Rental]?
    var myRequests: [Request]?
    var myTransactions: [Rental]?
    
    var myFilteredListings: [Rental]?
    var myFilteredRequests: [Request]?
    var myFilteredTransactions: [Rental]?
        
    var activeUser: User {
        return AuthState.shared.getUser()!
    }
    
    init(delegate: ProfileViewModelDelegate) {
        self.delegate = delegate
        fetchUserRentals()
        fetchUserRequests()
    }

    func fetchUserRentals() {
        profileService.getRentals { items, error in
            guard error == nil,
                let rentals = items as? [Rental] else { return }
            self.myListings = rentals
            self.myFilteredListings = rentals
            self.delegate.didGetRentals()
        }
    }
    
    func fetchUserRequests() {
        profileService.getRequests { items, error in
            guard error == nil,
            let requests = items as? [Request] else { return }
            self.myRequests = requests
            self.myFilteredRequests = requests
            self.delegate.didGetRequests()
        }
    }
    
    func fetchProfilePicture() {
        guard let url = activeUser.profilePictureURL else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                var updatedUser = self.activeUser
                updatedUser.profilePicture = image
                AuthState.shared.setUser(updatedUser)
                self.delegate.didDownloadProfilePicture(image)
            }
        }.resume()
    }
    
    func loadUserAssets() {
        self.delegate.didUpdateProfilePicture(forUser: activeUser)
    }
    
    func filterRequests(withText text: String) {
        guard text != "" else {
            return myFilteredListings = myListings
        }
        let searchTerm = text.lowercased()
        myFilteredListings = myListings?.filter { listing -> Bool in
            return listing.title.lowercased().contains(searchTerm)
        }
    }
    
}
