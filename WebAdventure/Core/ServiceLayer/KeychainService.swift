//
//  KeychainService.swift
//  WebAdventure
//
//  Created by Anton Zyabkin on 22.02.2023.
//

import Foundation
import Security
import SwiftKeychainWrapper

protocol KeychainServicable {
    func save(_ value: String, for key: KeychainWrapper.Keys)
    func fetch(for key: KeychainWrapper.Keys) -> String?
    func deleteItem(for key: KeychainWrapper.Keys) -> Bool
    func deleteAll() -> Bool
}

final class KeychainService{
    
    let decoder: DecoderServicable
    
    init(decoder: DecoderServicable) {
        self.decoder = decoder
    }
}

extension KeychainService: KeychainServicable {
    func save(_ value: String, for key: KeychainWrapper.Keys) {
        KeychainWrapper.standard.set(value, forKey: key.rawValue)
    }
    
    func fetch(for key: KeychainWrapper.Keys) -> String? {
        return KeychainWrapper.standard.string(forKey: key.rawValue)
    }
    
    func deleteItem(for key: KeychainWrapper.Keys) -> Bool {
        return KeychainWrapper.standard.removeObject(forKey: key.rawValue)
    }
    
    func deleteAll() -> Bool {
        return KeychainWrapper.standard.removeAllKeys()
    }
}

extension KeychainWrapper {
    enum Keys: String {
        case refreshToken = "refreshToken"
        case accessToken = "accessToken"
        case expiresIn = "expiresIn"
    }
}
