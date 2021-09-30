//
//  FeedService.swift
//  
//
//  Created by Juan Andres Vasquez Ferrer on 10-09-21.
//

import Foundation

class FeedService: BaseService {
    
    override var baseURL: String {
        return self.url.absoluteString
    }
    
    let url: URL
    
    init(url: URL) {
        self.url = url
    }

     func getFeed(completion: @escaping(Result<FeedItemsModel,Error>) -> Void) {
        
        guard let urlRequest = self.getUrlRequest(with: url) else {
            completion(.failure(CustomErrorModel(reason: "getting url request")))
            return
        }
        
        session.dataTask(with: urlRequest) { (data, _ , error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(CustomErrorModel(reason: "data is nil")))
                return
            }
                        
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let data = try decoder.decode(FeedItemsModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }catch (let error) {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}
