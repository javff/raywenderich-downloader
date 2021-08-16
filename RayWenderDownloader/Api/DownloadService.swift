//
//  DownloadService.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/13/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation

class LessonService: BaseService {

    func getDownloadVideoInfo(withURL videoURL: URL? = nil, lessonId: Int?, completion: @escaping (Result<[VideoModel], Error>) -> Void) {
        
        let url = URL(string: "\(self.baseURL)/videos/\(lessonId ?? 0)/download") 
        
        guard let finalURL = videoURL ?? url else {
            completion(.failure(CustomErrorModel(reason: "getting url request")))
            return
        }
        
        guard let request = self.getUrlRequest(with: finalURL) else {
            completion(.failure(CustomErrorModel(reason: "getting url request")))
            return
        }
        
        session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {
                completion(.failure(CustomErrorModel(reason: "data is nil")))
                return
            }

            do {
                let downloadModel = try JSONDecoder().decode(DownloadModel.self, from: data)
                completion(.success(downloadModel.data))
                
            } catch (let error) {
                completion(.failure(error))
            }
        }.resume()
    }
}
