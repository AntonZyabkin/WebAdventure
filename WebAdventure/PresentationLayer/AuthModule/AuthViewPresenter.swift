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
    
    private let apiService: ApiServicable
    private let keychainService: KeychainServicable
    private var captchaKey = ""
    
    init(apiService: ApiServicable, keychainService: KeychainServicable) {
        self.apiService = apiService
        self.keychainService = keychainService
    }
    private func convertBase64ToImage(imageString: String) -> UIImage {
        let test = imageString.replacingOccurrences(of: "data:image/png;base64,", with: "")
        let imageData = Data(base64Encoded: test)!
        return UIImage(data: imageData)!
    }
    private func showError(error: String) {
        DispatchQueue.main.async {
            self.view?.showErrorMessage(error)
        }
    }
}


extension AuthViewPresenter: AuthViewPresenterProtocol {
    func authButtonDidPressed(_ login: String, _ password: String, _ captcha: String) {
        let request = AuthRequest(username: login, password: password, captcha: Captcha(key: captchaKey, value: captcha))
        apiService.sendAuthRequest(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                
                if let errors = response.validation {
                    self.startLoadCaptcha()
                    var message = response.resultMessage + "\n"
                    if let captchaError = errors.captcha?.first {
                        message += captchaError + "\n"
                    }
                    if let passwordError = errors.password?.first {
                        message += passwordError + "\n"
                    }
                    if let usernameError = errors.username?.first {
                        message += usernameError
                    }
                    self.showError(error: message)
                }
                if let dataError = response.data?.message {
                    self.startLoadCaptcha()
                    self.showError(error: dataError)
                }
                guard
                    let refreshToken = response.data?.refreshToken,
                    let accessToken = response.data?.accessToken,
                    let expiresIn = response.data?.expiresIn
                else {
                    break
                }
                
                self.keychainService.save(refreshToken, for: .refreshToken)
                self.keychainService.save(accessToken, for: .accessToken)
                self.keychainService.save(String(expiresIn), for: .expiresIn)
                self.view?.dismiss(animated: true)
            case .failure(let error):
                self.startLoadCaptcha()
                print(error)
                self.showError(error: error.localizedDescription)
            }
        }
    }
    
    func startLoadCaptcha() {
        apiService.sendCaptchaRequest { result in
            switch result {
            case .success(let success):
                self.captchaKey = success.data.key
                let image = self.convertBase64ToImage(imageString: success.data.imageData)
                DispatchQueue.main.async {
                    self.view?.configureCaptcha(with: image)
                }
            case .failure(let failure):
                    print(failure.localizedDescription)
            }
        }
    }
}
