//
//  VideoService.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/17/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation


class VideoService: BaseService {
    
    override var baseURL: String {
        return "https://videos.raywenderlich.com/api/v1"
    }
    
    func getVideoInfo(videoId: Int, completion: @escaping(Result<VideoInfoModel,Error>) -> Void) {
        
        guard let url = URL(string:"\(self.baseURL)/videos/\(videoId).json") else {
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
                let video = try JSONDecoder().decode(VideoInfoModel.self, from: data)
                completion(.success(video))
            }catch (let error) {
                completion(.failure(error))
            }
            
        }.resume()
    }
}
