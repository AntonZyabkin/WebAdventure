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
    func save(_ value: String, for key: KeychainWrapper.Keys) -> Bool
    func fetch(for key: KeychainWrapper.Keys) -> String?
    func deleteItem(for key: KeychainWrapper.Keys) -> Bool
    func deleteAll() -> Bool
}

final class KeychainService{
    
    let decoder: DecoderServicable
    
    init(decoder: DecoderServicable) {
        self.decoder = decoder
    }
    enum KeychainError: Error {
        case itemNotFound
        case duplicateItem
        case invalidItemFormat
        case unexpectedStatus(OSStatus)
    }
}

extension KeychainService: KeychainServicable {
    func save(_ value: String, for key: KeychainWrapper.Keys) -> Bool {
        return KeychainWrapper.standard.set(value, forKey: key.rawValue)
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
        case sbisSessionID = "X-SBISSessionID"
        case sbisLogin = "sbisLogin"
        case sbisPassword = "sbisPassword"
        case tochkaAccessToken = "accessToken"
        case tochkaJWT = "JWT"
        case lastPaymentDate = "lastPaymentDate"
        case tochkaAccountID = "accountID"
        case ofdAuthToken = "ofdAuthToken"
        case ofdLogin = "ofdLogin"
        case ofdPassword = "ofdPassword"
    }
}
