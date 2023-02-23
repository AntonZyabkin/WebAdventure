//
//  AuthEndpoints.swift
//  WebAdventure
//
//  Created by Anton Zyabkin on 22.02.2023.
//

import Foundation
import Moya

enum AuthEndpoints {
    case captcha
    case auth(request: AuthRequest)
    case fetchUser(request: UserRequest)
}

extension AuthEndpoints: TargetType {
    
    var headers: [String : String]? {
        switch self {
        case .captcha, .auth:
            return [:]
        case .fetchUser(let request):
            return ["accept" : "application/json",
                    "authorization" : "Bearer \(request.accessToken)"]
        }
    }
    
    var baseURL: URL {
        URL(string: "https://api-events.pfdo.ru")!
    }
    
    var path: String {
        switch self {
        case .auth:
            return "/v1/auth"
        case .captcha:
            return "/v1/captcha"
        case .fetchUser:
            return "/v1/user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .captcha, .auth:
            return .post
        case .fetchUser:
            return .get
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .captcha, .auth, .fetchUser:
            return [:]
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .captcha, .fetchUser:
            return .requestPlain
        case .auth(let request):
            return requestCompositeParameters(request, parameters)
        }
    }
}

extension Moya.TargetType {
    func requestCompositeParameters(_ body: Encodable, _ parameters: [String: Any]) -> Task {
        var bodyDict: [String: Any] = [:]
        do {
            bodyDict = try body.asDictionary()
        } catch let error {
            print(error.localizedDescription)
        }
        return .requestCompositeParameters(
            bodyParameters: bodyDict,
            bodyEncoding: JSONEncoding(),
            urlParameters: parameters)
    }
}
