//
//  File.swift
//  
//
//  Created by Juan Andres Vasquez Ferrer on 10-09-21.
//

import Foundation

public final class RayWenderClient {
    
    
    private let baseUrl = "https://api.raywenderlich.com/api"
    private let path = "contents"
    
    private var links: FeedLinks?
    
    private var nextPageUrl: URL?  {
        guard let nextUrl = links?.next,
              let url = URL(string: nextUrl) else { return nil }
        return url
    }
    
    private var baseUrlEndpoint: String {
        return "\(baseUrl)/\(path)"
    }
    
    public init() {}
    
    public func getFeed(query: String? = nil, completion: @escaping(Result<FeedItemsModel,Error>) -> Void) {
        var urlComponents = URLComponents(string: baseUrlEndpoint)
        var queryItems: [URLQueryItem] = []
        queryItems = [
            URLQueryItem(name: "filter[content_types][]", value: "collection"),
            URLQueryItem(name: "filter[content_types][]", value: "screencast"),
            URLQueryItem(name: "sort", value: "-released_at")
        ]
        if let query = query {
            queryItems.append(URLQueryItem(name: "filter[q]", value: query))
        }
        
        let saveNextPage = query == nil
        
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else { return }
        
        let service = FeedService(url: url)
        
        service.getFeed { response in
            switch response {
            case .success(let data):
                completion(.success(data))
                if saveNextPage {
                    self.links = data.links
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getNextPage(completion: @escaping(Result<FeedItemsModel,Error>) -> Void) {
        guard let url = nextPageUrl else {
            completion(.failure(NSError()))
            return
        }
        let service = FeedService(url: url)
        service.getFeed(completion: completion)
    }
}
