//
//  File.swift
//  
//
//  Created by Juan Andres Vasquez Ferrer on 10-09-21.
//

import Foundation

public class RayWenderClient {
    
    public init() {}
    
    public func getFeed(url: URL, completion: @escaping(Result<FeedItemsModel,Error>) -> Void) {
        let service = FeedService(url: url)
        service.getFeed(completion: completion)
    }
}
