//
//  SettingsViewModel.swift
//  Alamofire
//
//  Created by Jacob Goldfarb on 2020-04-14.
//

import Foundation

struct SettingsViewModel {
    
    func logOut() {
        AuthState.shared.logOut()
    }
}
