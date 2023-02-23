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

struct Captcha: Codable {
    let key, value: String
}

//MARK: - UserRequest
struct UserRequest: Codable {
    let accessToken: String
}
