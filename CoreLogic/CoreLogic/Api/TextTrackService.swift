//
//  TextTrackService.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/19/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation

class TextTrackService: BaseService {
    
    func getUrlTextTrack(playerUrl: URL, completion: @escaping (Result<URL,Error>) -> Void) {
        
        guard let urlRequest = self.getUrlRequest(with: playerUrl) else {
            completion(.failure(CustomErrorModel(reason: "error getting url request")))
            return
        }
        
        self.session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            
        
        }.resume()
    }
}
