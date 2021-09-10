//
//  File.swift
//  
//
//  Created by Juan Andres Vasquez Ferrer on 10-09-21.
//

import Foundation

public class RayWenderClient {
    
    let service = FeedService()
    
    public init() {}
    
    public func getFeed(completion: @escaping(Result<FeedItemsModel,Error>) -> Void) {
        service.getFeed(completion: completion)
    }
}
