//
//  DecoderService.swift
//  WebAdventure
//
//  Created by Anton Zyabkin on 22.02.2023.
//

import Foundation


protocol DecoderServicable{
    func decode<T: Decodable>(_ data: Data, complition: @escaping (Result<T, Error>) -> Void)
    func encode<T: Encodable>(_ data: T, complition: @escaping (Result<Data, Error>) -> Void)
}

final class DecoderService{
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = JSONEncoder()
}

extension DecoderService: DecoderServicable {
    func decode<T: Decodable>(_ data: Data, complition: @escaping (Result<T, Error>) -> Void) {
        do {
            let result = try self.jsonDecoder.decode(T.self, from: data)
            complition(.success(result))
        } catch  {
            complition(.failure(error))
        }
    }
    
    func encode<T: Encodable>(_ data: T, complition: @escaping (Result<Data, Error>) -> Void) {
        do {
            let result = try self.jsonEncoder.encode(data)
            complition(.success(result))
        } catch  {
            complition(.failure(error))
        }
    }
}
