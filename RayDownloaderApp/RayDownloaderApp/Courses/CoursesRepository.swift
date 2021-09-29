//
//  CoursesRepository.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 10-09-21.
//

import Foundation
 import BussinnesLogic

protocol CoursesRepositoryProtocol {
    func getFeed(completion: @escaping(Result<[CourseFeedViewModel],Error>) -> Void)
}


class CoursesRepository: CoursesRepositoryProtocol {
    
    let client = RayWenderClient()
    
    func getFeed(completion: @escaping (Result<[CourseFeedViewModel], Error>) -> Void) {
        client.getFeed { (response) in
            switch response {
            case .success(let data):
                let result = data.data.map { self.transformResponse(item: $0) }
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func transformResponse(item: FeedModel) -> CourseFeedViewModel {
        return CourseFeedViewModel(
            id: item.id,
            headline: item.attributes.name,
            platform: item.attributes.technologyTripleString,
            description: item.attributes.descriptionPlainText,
            metaInfo: "",
            imageUrl: item.attributes.cardArtworkUrl,
            name: item.attributes.name
        )
    }
}
