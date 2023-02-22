//
//  Requests.swift
//  WebAdventure
//
//  Created by Anton Zyabkin on 22.02.2023.
//

import Foundation

// MARK: - AuthRequest
struct AuthRequest: Codable {
    let username, password: String
    let captcha: Captcha
}

// MARK: - CAPTCHA
struct Captcha: Codable {
    let key, value: String
}
