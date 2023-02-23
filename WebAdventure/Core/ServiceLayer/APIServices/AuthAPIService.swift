//
//  AuthAPIService.swift
//  WebAdventure
//
//  Created by Anton Zyabkin on 22.02.2023.
//

import Moya

protocol ApiServicable {
    func sendAuthRequest(request: AuthRequest , complition: @escaping (Result<AuthResponce, Error>) -> Void)
    func sendCaptchaRequest(complition: @escaping (Result<CaptchaResponce, Error>) -> Void)
    func sendUserRequest(request: UserRequest, complition: @escaping (Result<UserResponce, Error>) -> Void)
}
final class ApiService{
    private let networkService: Networkable

    init(networkService: Networkable) {
        self.networkService = networkService
    }
}

extension ApiService: ApiServicable {

    func sendAuthRequest(request: AuthRequest , complition: @escaping (Result<AuthResponce, Error>) -> Void) {
        networkService.request(AuthEndpoints.auth(request: request), complition: complition)
    }
    func sendCaptchaRequest(complition: @escaping (Result<CaptchaResponce, Error>) -> Void) {
        networkService.request(AuthEndpoints.captcha, complition: complition)
    }
    func sendUserRequest(request: UserRequest, complition: @escaping (Result<UserResponce, Error>) -> Void) {
        networkService.request(AuthEndpoints.fetchUser(request: request), complition: complition)
    }
}

