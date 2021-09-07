//
//  VideoPlayerService.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/19/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation


class VideoPlayerService: BaseService {
    
    func getTextTrack(videoId: Int, completion: @escaping (Result<URL,Error>) -> Void) {
        
        getVideoPlayer(videoId: videoId) { (response) in
            switch response {
            case .success(let url):
                self.getTrackUrl(videoPlayerUrl: url) { (response) in
                    switch response {
                    case .success(let url):
                        self.getTextTrackInfo(trackUrl: url, completion: completion)
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func getVideoPlayer(videoId: Int, completion: @escaping (Result<URL,Error>) -> Void) {
        
        getStream(videoId: videoId) { (response) in
            switch response {
            case .success(let stream):
                self.getVideoPlayer(stream: stream, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func getStream(videoId: Int, completion: @escaping (Result<StreamModel, Error>) -> Void) {
        
        guard let url = URL(string: "\(self.baseURL)/videos/\(videoId)/stream") else {
            completion(.failure(CustomErrorModel(reason: "error getting url request")))
            return
        }

        guard let urlRequest = self.getUrlRequest(with: url) else {
            completion(.failure(CustomErrorModel(reason: "error getting url request")))
            return
        }
        
        self.session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(CustomErrorModel(reason: "failed getting cast URLResponse")))
                return
            }
   
            do {
                let streamModel = try JSONDecoder().decode(StreamModel.self, from: data)
                completion(.success(streamModel))
            } catch (let error) {
                completion(.failure(error))
            }

        }.resume()
    }
    
    private func getVideoPlayer(stream: StreamModel, completion: @escaping (Result<URL,Error>) -> Void) {
        
        guard let urlString = stream.data?.attributes?.url, let url = URL(string: urlString) else {
            completion(.failure(CustomErrorModel(reason: "error getting url request")))
            return
        }
        
        guard let urlRequest = self.getUrlRequest(with: url) else {
            completion(.failure(CustomErrorModel(reason: "error getting url request")))
            return
        }
                
        self.session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(CustomErrorModel(reason: "failed getting cast URLResponse")))
                return
            }
            
            guard let location = response.allHeaderFields["Location"] as? String,
                let urlLocation = URL(string: location) else {
                    completion(.failure(CustomErrorModel(reason: "failed getting location header")))
                    return
            }
            
            completion(.success(urlLocation))
            
        }.resume()
        
    }
    
    private func getTextTrackInfo(trackUrl: URL, completion: @escaping (Result<URL,Error>) -> Void) {
        
        DispatchQueue.global().async {
            do {
                let info = try String(contentsOf: trackUrl)
                guard let textTrackInfo = ScrapingUtils.getPathForDownloadTextTrack(textContent: info) else {
                    completion(.failure(CustomErrorModel(reason: "failed scraping track url")))
                    return
                }
                
                guard let url = ScrapingUtils.createTextTrackDownload(content: textTrackInfo, url: trackUrl) else {
                    completion(.failure(CustomErrorModel(reason: "failed scraping track url")))
                    return
                }
                    
                completion(.success(url))
                
            } catch (let error) {
                completion(.failure(error))
            }
        }
    }
    
    func getTrackUrl(videoPlayerUrl: URL, completion: @escaping (Result<URL,Error>) -> Void) {
        
        DispatchQueue.global().async {
            do {
                let info = try String(contentsOf: videoPlayerUrl)
                guard let url = ScrapingUtils.getSubtitleUrl(textContent: info) else {
                    completion(.failure(CustomErrorModel(reason: "failed scraping track url")))
                    return
                }
                completion(.success(url))
                
            } catch (let error) {
                completion(.failure(error))
            }
        }
        
    }
}
