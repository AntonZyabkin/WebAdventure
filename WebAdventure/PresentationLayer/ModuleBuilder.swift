//
//  ModuleBuilder.swift
//  WebAdventure
//
//  Created by Anton Zyabkin on 22.02.2023.
//

import UIKit
import Moya

protocol Builder {
    func buildInfoViewController() -> InfoViewController
    func buildAuthViewController() -> AuthViewController
}

final class ModuleBuilder {
    private let networkService: Networkable
    private let decoderService: DecoderServicable
    private let keychainService: KeychainServicable
    private let apiService: ApiService

    init() {
        decoderService = DecoderService()
        keychainService = KeychainService(decoder: decoderService)
        networkService = NetworkService(decoderService: decoderService)
        apiService = ApiService(networkService: networkService)
    }
}

extension ModuleBuilder: Builder {
    
    func buildAuthViewController() -> AuthViewController {
        let viewController = AuthViewController()
        let presenter = AuthViewPresenter(apiService: apiService, keychainService: keychainService)
        viewController.presenter = presenter
        presenter.view = viewController
        return viewController
    }
    func buildInfoViewController() -> InfoViewController {
        let infoViewController = InfoViewController()
        let presenter = InfoViewPresenter(apiService: apiService, keychainService: keychainService, moduleBuilder: self)
        infoViewController.presenter = presenter
        presenter.view = infoViewController
        return infoViewController
    }
}
