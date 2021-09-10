//
//  FeedService.swift
//  
//
//  Created by Juan Andres Vasquez Ferrer on 10-09-21.
//

import Foundation

class FeedService: BaseService {
    
    override var baseURL: String {
        return "https://api.raywenderlich.com/api/"
    }
    
     func getFeed(completion: @escaping(Result<FeedItemsModel,Error>) -> Void) {
        
        guard let url = URL(string:"\(self.baseURL)/contents?filter%5Bcontent_types%5D%5B%5D=collection&filter%5Bcontent_types%5D%5B%5D=screencast&sort=-released_at") else {
            completion(.failure(CustomErrorModel(reason: "getting url request")))
            return
        }
        
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
