//
//  LessonsProvider.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/17/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation

public protocol ItemsProviderProtocol: class {
    func getLessonsInfo(id: Int) -> [VideoModel]
    func getTutorialInfo(url: URL) -> [VideoModel]
    func getVideoInfo(videoId: Int) -> VideoInfoModel?
    func getTrackForVideo(videoId: Int) -> URL?
}

public class ItemsProvider: ItemsProviderProtocol {


    let semaphore = DispatchSemaphore(value: 0)
    let videoService = VideoService()
    let lessonService = LessonService()
    let videoPlayerService = VideoPlayerService()
    
    public init() {}
    
    public func getLessonsInfo(id: Int) -> [VideoModel] {
        var results: [VideoModel] = []
        lessonService.getDownloadVideoInfo(lessonId: id) { (response) in
            switch response {
            case .success(let videos):
                print("scraping Info for video \(id)")
                results.append(contentsOf: videos)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.semaphore.signal()
        }
        self.semaphore.wait()
        return results
    }
    
    public func getTutorialInfo(url: URL) -> [VideoModel] {
        
        var results: [VideoModel] = []
        
        self.lessonService.getDownloadVideoInfo(withURL: url, lessonId: nil) { (response) in
            switch response {
            case .success(let videos):
                results.append(contentsOf: videos)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.semaphore.signal()
        }
        
        self.semaphore.wait()
        return results
    }
    
    public func getVideoInfo(videoId: Int) -> VideoInfoModel? {
        
        var results: [VideoInfoModel] = []
        
        videoService.getVideoInfo(videoId: videoId) { (response) in
            switch response {
            case .success(let videoInfoModel):
                print("scraping video download Info for video \(videoId)")
                results.append(videoInfoModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.semaphore.signal()
        }
        self.semaphore.wait()
        return results.first
    }
    
    public func getTrackForVideo(videoId: Int) -> URL? {
        var urlResult: URL?
        
        videoPlayerService.getTextTrack(videoId: videoId) { (response) in
            switch response {
            case .success(let url):
                print("scraping subtitles for video \(videoId)")
                urlResult = url
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.semaphore.signal()
        }
        self.semaphore.wait()
        return urlResult
    }
    
}
