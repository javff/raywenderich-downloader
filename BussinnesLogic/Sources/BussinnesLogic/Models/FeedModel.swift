//
//  FeedModel.swift
//  
//
//  Created by Juan Andres Vasquez Ferrer on 10-09-21.
//

import Foundation

public struct FeedItemsModel: Decodable {
    public let data: [FeedModel]
    public let links: FeedLinks
}

public struct FeedModel: Decodable {
    public let id: String
    public let attributes: FeedAttributes
}

public struct FeedAttributes: Decodable {
    public let name: String
    public let description: String
    public let releasedAt: String
    public let duration: Int
    public let technologyTripleString: String
    public let cardArtworkUrl: String
    public let descriptionPlainText: String
}

public struct FeedLinks: Decodable {
    public let next: String
}
