//
//  Responses.swift
//  WebAdventure
//
//  Created by Anton Zyabkin on 22.02.2023.
//

import Foundation
// MARK: - CaptchaResponce
struct CaptchaResponce: Codable {
    let resultCode, resultMessage: String
    let data: CaptchaDataClass

    enum CodingKeys: String, CodingKey {
        case resultCode = "result_code"
        case resultMessage = "result_message"
        case data
    }
}

struct CaptchaDataClass: Codable {
    let key, imageData: String

    enum CodingKeys: String, CodingKey {
        case key
        case imageData = "image_data"
    }
}

// MARK: - AuthResponce
struct AuthResponce: Codable {
    let resultCode, resultMessage: String
    let data: AuthDataClass?
    let validation: Validation?
    enum CodingKeys: String, CodingKey {
        case resultCode = "result_code"
        case resultMessage = "result_message"
        case data, validation
    }
}
struct AuthResponceSuccess: Codable {
    let resultCode, resultMessage: String
    let data: AuthDataClass
    enum CodingKeys: String, CodingKey {
        case resultCode = "result_code"
        case resultMessage = "result_message"
        case data
    }
}

struct AuthDataClass: Codable {
    let tokenType: String?
    let expiresIn: Int?
    let accessToken, refreshToken: String?
    let message: String?
    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case message
    }
}
struct Validation: Codable {
    let username, password, captcha: [String]?
}


// MARK: - UserResponce
struct UserResponce: Codable {
    let resultCode, resultMessage: String
    let data: UserDataClass

    enum CodingKeys: String, CodingKey {
        case resultCode = "result_code"
        case resultMessage = "result_message"
        case data
    }
}

struct UserDataClass: Codable {
    let profile: Profile
}

struct Profile: Codable {
    let name: String
}
