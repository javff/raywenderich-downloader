//
//  CourseContentService.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/13/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation

class CourseContentService: BaseService {
    
    func getCourse(courseId: Int, completion: @escaping(Result<CourseModel, Error>) -> Void) {
        
        guard let url = URL(string: "\(self.baseURL)/contents/\(courseId)") else {return}
        
        guard let request = self.getUrlRequest(with: url) else {
            completion(.failure(CustomErrorModel(reason: "error getting url request")))
            return
        }
        
         session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(CustomErrorModel(reason: "data is nil")))
                return
            }

            do {
                let courseModel = try JSONDecoder().decode(CourseModel.self, from: data)
                completion(.success(courseModel))
                
            } catch (let error) {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
}
