//
//  InfoViewPresenter.swift
//  WebAdventure
//
//  Created by Anton Zyabkin on 23.02.2023.
//

import Foundation
import UIKit

protocol InfoViewPresenterProtocol {
    func startLoadUser()
    func logOut()
}

final class InfoViewPresenter {
    weak var view: InfoViewControllerProtocol?
    
    private let apiService: ApiServicable
    private let keychainService: KeychainServicable
    private let moduleBuilder: Builder

    init(apiService: ApiServicable, keychainService: KeychainServicable, moduleBuilder: Builder) {
        self.apiService = apiService
        self.keychainService = keychainService
        self.moduleBuilder = moduleBuilder
    }
}


extension InfoViewPresenter: InfoViewPresenterProtocol {
    func startLoadUser() {
        guard let accessToken = keychainService.fetch(for: .accessToken) else {
            let authViewController = moduleBuilder.buildAuthViewController()
            authViewController.loader = self
            view?.presentAuthViewController(viewController: authViewController)
            return
        }
        let request = UserRequest(accessToken: accessToken)
        apiService.sendUserRequest(request: request) { responce in
            switch responce {
            case .success(let result):
                self.view?.updateLabel(with: result.data.profile.name)
            case .failure(let error):
                print(error)
            }
        }
    }
    func logOut() {
        keychainService.deleteAll()
        startLoadUser()
    }
}
