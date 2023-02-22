//
//  AuthViewPresenter.swift
//  WebAdventure
//
//  Created by Anton Zyabkin on 22.02.2023.
//

import Foundation
import UIKit

protocol AuthViewPresenterProtocol {
    func startLoadCaptcha()
    func authButtonDidPressed(_ login: String, _ password: String, _ captcha: String)
}

final class AuthViewPresenter {
    weak var view: AuthViewControllerProtocol?
    
    private let authApiService: AuthApiServicable
    private let keychainService: KeychainServicable
    private var captchaKey = ""
    
    init(authApiService: AuthApiServicable, keychainService: KeychainServicable) {
        self.authApiService = authApiService
        self.keychainService = keychainService
    }
    private func convertBase64ToImage(imageString: String) -> UIImage {
        let test = imageString.replacingOccurrences(of: "data:image/png;base64,", with: "")
        let imageData = Data(base64Encoded: test)!
        return UIImage(data: imageData)!
    }
}


extension AuthViewPresenter: AuthViewPresenterProtocol {
    func authButtonDidPressed(_ login: String, _ password: String, _ captcha: String) {
        let request = AuthRequest(username: login, password: password, captcha: Captcha(key: captchaKey, value: captcha))
        authApiService.sendAuthRequest(request: request) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func startLoadCaptcha() {
        authApiService.sendCaptchaRequest { result in
            switch result {
            case .success(let success):
                self.captchaKey = success.data.key
                let image = self.convertBase64ToImage(imageString: success.data.imageData)
                self.view?.configureCaptcha(with: image)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
