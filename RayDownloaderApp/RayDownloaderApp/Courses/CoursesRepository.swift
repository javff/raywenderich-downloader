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
    func getNextPage(completion: @escaping(Result<[CourseFeedViewModel],Error>) -> Void)
}


class CoursesRepository: CoursesRepositoryProtocol {
    
    let client = RayWenderClient()
    var links: FeedLinks?
    
    func getFeed(completion: @escaping (Result<[CourseFeedViewModel], Error>) -> Void) {
        
        // TODO: fixing hardcoded url
        guard let url = URL(string: "https://api.raywenderlich.com/api/contents?filter%5Bcontent_types%5D%5B%5D=collection&filter%5Bcontent_types%5D%5B%5D=screencast&sort=-released_at") else {
            return
        }
        
        client.getFeed(url: url) { (response) in
            switch response {
            case .success(let data):
                let result = data.data.map { self.transformResponse(item: $0) }
                self.links = data.links
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getNextPage(completion: @escaping (Result<[CourseFeedViewModel], Error>) -> Void) {
        guard let links = links,
              let url = URL(string: links.next) else { return }
        
        client.getFeed(url: url) { (response) in
            switch response {
            case .success(let data):
                let result = data.data.map { self.transformResponse(item: $0) }
                self.links = data.links
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
            name: item.attributes.name,
            duration: item.attributes.duration
        )
    }
}
