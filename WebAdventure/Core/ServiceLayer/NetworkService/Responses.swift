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
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case resultCode = "result_code"
        case resultMessage = "result_message"
        case data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let key, imageData: String

    enum CodingKeys: String, CodingKey {
        case key
        case imageData = "image_data"
    }
}

// MARK: - AuthResponce
struct AuthResponce: Codable {
    let resultCode, resultMessage: String
    let data: AuthDataClass

    enum CodingKeys: String, CodingKey {
        case resultCode = "result_code"
        case resultMessage = "result_message"
        case data
    }
}

// MARK: - DataClass
struct AuthDataClass: Codable {
    let tokenType: String
    let expiresIn: Int
    let accessToken, refreshToken: String

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
