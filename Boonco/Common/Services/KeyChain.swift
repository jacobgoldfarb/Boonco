//
//  KeyChain.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-12.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation

struct KeyChain {
    
    static func storeToken(_ value: String, key: String = "jwt") {
        guard let data = value.data(using: .utf8) else { return }
        let status = KeyChain.save(key: key, data: data)
        print("status: ", status)
    }
    
    static func getToken(withKey key: String = "jwt") -> String? {
        if let receivedData = KeyChain.load(key: key) {
            let result = String(data: receivedData, encoding: .utf8)
            return result
        }
        return nil
    }
    
    static func deleteToken(withKey key: String = "jwt") {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key] as [String : Any]
        SecItemDelete(query as CFDictionary)
    }

    static private func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]
        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil)
    }

    static private func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
}

