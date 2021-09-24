//
//  HomeRepository.swift
//  CeibaTest
//
//  Created by Juan Andres Vasquez Ferrer on 16-09-21.
//

import Foundation


protocol HomeRepositoryProtocol {
    func getFeedHome(completion:@escaping(Result<[String],Error>) -> Void)
}


class FakeHomeRepository: HomeRepositoryProtocol {
    
    func getFeedHome(completion: @escaping (Result<[String], Error>) -> Void) {
        completion(.success([
            "Hola",
            "como",
            "estas"
        ]))
    }
}
