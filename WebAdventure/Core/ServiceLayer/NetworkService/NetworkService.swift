//
//  NetworkService.swift
//  WebAdventure
//
//  Created by Anton Zyabkin on 22.02.2023.
//

import Foundation
import Moya


protocol Networkable {
    func request<T>(_ target: TargetType, complition: @escaping (Result<T, Error>) -> Void) where T: Decodable
}

final class NetworkService {
    private let decoderService: DecoderServicable
    private let provider = MoyaProvider<MultiTarget>()
    init(decoderService: DecoderServicable) {
        self.decoderService = decoderService
    }
}

enum NetworkError: Error {
    case urlError
    case responseError
    case statusCodeNot200
    case dataError
    case unknownError
}

extension NetworkService: Networkable {
    
    func request<T>(_ target: TargetType, complition: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        let multiTarget = MultiTarget(target)
        func complitionHandler(_ result: Result<T, Error>) {
            DispatchQueue.main.async {
                complition(result)
            }
        }
        DispatchQueue.global(qos: .userInitiated).async {  [weak self] in
            guard let self = self else {
                return
            }
            self.provider.request(multiTarget) { result in
                switch result {
                case .failure(let error):
                    complition(.failure(error))
                case .success(let response):
                    guard let urlResponse = response.response else {
                        let error = NetworkError.responseError
                        complitionHandler(.failure(error))
                        return
                    }
                    switch urlResponse.statusCode {
                    case 200...210:
                        self.decoderService.decode(response.data, complition: complition)
                    case 300...599:
                        print("Status code \(urlResponse.statusCode)")
                        self.decoderService.decode(response.data, complition: complition)
                        break
                    default:
                        let error = NetworkError.unknownError
                        complitionHandler(.failure(error))
                        return
                    }
                }
            }
        }
    }
}
