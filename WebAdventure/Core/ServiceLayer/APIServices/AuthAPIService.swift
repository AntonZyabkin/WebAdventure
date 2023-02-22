//
//  AuthAPIService.swift
//  WebAdventure
//
//  Created by Anton Zyabkin on 22.02.2023.
//

import Moya

protocol AuthApiServicable {
    func sendAuthRequest(request: AuthRequest , complition: @escaping (Result<AuthResponce, Error>) -> Void)
    func sendCaptchaRequest(complition: @escaping (Result<CaptchaResponce, Error>) -> Void)

}


final class AuthApiService{
    private let networkService: Networkable

    init(networkService: Networkable) {
        self.networkService = networkService
    }
}

extension AuthApiService: AuthApiServicable {

    func sendAuthRequest(request: AuthRequest , complition: @escaping (Result<AuthResponce, Error>) -> Void) {
        networkService.request(AuthEndpoints.auth(request: request), complition: complition)
    }
    func sendCaptchaRequest(complition: @escaping (Result<CaptchaResponce, Error>) -> Void) {
        networkService.request(AuthEndpoints.captcha, complition: complition)
    }
    
}

