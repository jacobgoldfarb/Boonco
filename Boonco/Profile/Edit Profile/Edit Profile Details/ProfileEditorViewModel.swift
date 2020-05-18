//
//  ProfileEditorModel.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-11.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol ProfileEditorModelDelegate {
    func didUpdateProfileData()
}

class ProfileEditorViewModel {
    
    let delegate: ProfileEditorModelDelegate
    let profileService: ProfileService = ProfileService()
    var activeUser: User {
        didSet {
            AuthState.shared.setUser(activeUser)
        }
    }
    
    var profilePicture: UIImage?
    var currentPicture: UIImage!
    
    //MARK: Initializer
    
    init(delegate: ProfileEditorModelDelegate) {
        self.delegate = delegate
        self.activeUser = AuthState.shared.getUser()!
        
        self.currentPicture = self.profilePicture ?? Theme.standard.images.getProfilePlaceholder()
    }
    
    //MARK: Edit profile details
    
    func updateUser() {
        profileService.updateUser(activeUser) { (updatedUser, error) in
            
        }
        self.delegate.didUpdateProfileData()
    }
    
    func changeFirstName(to name: String) {
        activeUser.firstName = name
        updateUser()
    }
    
    func changeLastName(to name: String) {
        activeUser.lastName = name
        updateUser()
    }
    
    func changePhoneNumber(to number: String) {
        activeUser.phoneNumber = number
        updateUser()
    }
    
    func changeLocation(to location: String) {
        activeUser.address.city = location
        updateUser()
    }
    
    //MARK: Update profile picture
    
    func postProfilePicture() {
        profileService.postPhoto(currentPicture) { error in
            guard error == nil else { return }
            var updatedUser = self.activeUser
            updatedUser.profilePicture = self.currentPicture
            AuthState.shared.setUser(updatedUser)
        }
        self.profilePicture = currentPicture
    }
    
    func updateCurrentPicture(_ image: UIImage) {
        self.currentPicture = image
    }
}
