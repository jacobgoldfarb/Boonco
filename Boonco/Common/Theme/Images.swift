//
//  Images.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-29.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

struct Images {
    
    struct Names {
        static let folderEmptyGrey = "folderEmptyGrey"
        static let imagePlaceholder = "imagePlaceholder"
        static let itemExample = "itemExample"
        static let tinyPin = "tinyPin"
        static let tinyUser = "tinyUser"
        static let categoryPlaceholder = "categoryPlaceholder"
        static let profilePlaceholder = "DefaultDude"
        static let settingsIcon = "SettingsIcon"
        static let editProfileIcon = "EditPencilIcon"
        static let walletIcon = "BrownWalletIcon"
        static let viewsIcon = "viewsIcon"
        static let statusIcon = "statusIcon"
        static let borrowIcon = "home"
        static let lendIcon = "retail"
        static let activityIcon = "list"
        static let profileIcon = "profile"
        static let emailIcon = "email"
        static let phoneIcon = "phone"
        static let splash = "splash"
        static let horizontalEllipses = "HorizontalEllipses"
        static let userIcon = "UserIcon"
        static let clockIcon = "ClockIcon"
        static let locationIcon = "LocationIcon"
        static let durationIcon = "HourglassIcon"
    }
    
    func getSplash() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.splash)
    }
    
    func getFolderEmptyGrey() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.folderEmptyGrey)
    }
    
    func getImagePlaceholder() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.imagePlaceholder)
    }
    
    func getItemExample() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.itemExample)
    }
    
    func getTinyUser() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.tinyUser)
    }
    
    func getTinyPin() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.tinyPin)
    }
    
    func getCategoryPlaceholder() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.categoryPlaceholder)
    }
    
    func getProfilePlaceholder() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.profilePlaceholder)
    }
    
    func getSettingsIcon() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.settingsIcon)
    }
    
    func getEditProfileIcon() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.editProfileIcon)
    }
    
    func getWalletIcon() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.walletIcon)
    }
    
    func getViewsIcon() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.viewsIcon)
    }
    
    func getStatusIcon() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.statusIcon)
    }
    
    func getBorrowIcon() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.borrowIcon)
    }
    
    func getLendIcon() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.lendIcon)
    }
    
    func getActivityIcon() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.activityIcon)
    }
    
    func getProfileIcon() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.profileIcon)
    }

    func getEmailIcon() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.emailIcon)
    }
    
    func getPhoneIcon() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.phoneIcon)
    }
    
    func getAdditionalOptionsIcon() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.horizontalEllipses)
    }
    
    func getUserIcon() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.userIcon)
    }
    
    func getClockIcon() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.clockIcon)
    }
    
    func getLocationIcon() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.locationIcon)
    }
    
    func getDurationIcon() -> UIImage {
        return UIImage(imageLiteralResourceName: Names.durationIcon)
    }
}


