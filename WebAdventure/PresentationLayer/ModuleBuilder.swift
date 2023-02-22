//
//  ModuleBuilder.swift
//  WebAdventure
//
//  Created by Anton Zyabkin on 22.02.2023.
//

import UIKit
import Moya

protocol Builder {
}

final class ModuleBuilder {
    private let networkService: Networkable
    private let decoderService: DecoderServicable
    private let keychainService: KeychainServicable
    private let authAPIService: AuthApiService

    
    init() {
        decoderService = DecoderService()
        keychainService = KeychainService(decoder: decoderService)
        networkService = NetworkService(decoderService: decoderService)
        authAPIService = AuthApiService(networkService: networkService)
    }
}

extension ModuleBuilder: Builder {
    
    func buildOFDAuthViewController() -> AuthViewController {
        let viewController = AuthViewController()
        let presenter = AuthViewPresenter(authApiService: authAPIService, keychainService: keychainService)
        viewController.presenter = presenter
        presenter.view = viewController
        return viewController
    }
}
