//
//  EditProfileDetailsViewController+Subclasses.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-10.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

///The edit profile VC's are broken down into subclasses because we will need specific routings depending on what field we are editing
///Field characteristics will also differ

//MARK: Edit first name

class EditFirstNameViewController: EditProfileDetailViewController {
    
    init() {
        super.init(as: .firstName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//MARK: Edit last name

class EditLastNameViewController: EditProfileDetailViewController {
    
    init() {
        super.init(as: .lastName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//MARK: Edit phone number

class EditPhoneNumberViewController: EditProfileDetailViewController {
    
    init() {
        super.init(as: .phoneNumber)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//MARK: Edit password

class EditPasswordViewController: EditProfileDetailViewController {
    
    init() {
        super.init(as: .password)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//MARK: Edit location

class EditLocationViewController: EditProfileDetailViewController {
    
    init() {
        super.init(as: .location)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
