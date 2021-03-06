//
//  RayWenderCourseDownloader.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/14/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation


public struct ProgressTaskViewModel {
    public let total: Int
    public let completed: Int
    public let courseName: String
}

public class RayWenderCourseDownloader {
    
    let courseService = CourseContentService()
    let lessonsProvider: ItemsProviderProtocol
    
    public var progressSnapshot: ((ProgressTaskViewModel) -> Void)?
    
    public init(lessonsProvider: ItemsProviderProtocol = ItemsProvider()) {
        self.lessonsProvider = lessonsProvider
    }
    
    public func getCourseLessons(courseId: Int, quality: Quality, completion: @escaping(Result<[Lesson], Error>) -> Void) {
        courseService.getCourse(courseId: courseId) { (response) in
            switch response {
            case .success(let course):
                let items = self.getItemsForDownload(course, quality: quality)
                let result = self.transformResponse(items: items, courseName: course.name)
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK - Private use cases
    private func getItemsForDownload(_ course: CourseModel, quality: Quality) -> [Downloader.Item] {
        if course.lessons.isEmpty {
            return getTutorialForDownload(course, quality: quality)
        } else {
            return getLessonsForDownload(course, quality: quality)
        }
    }
    
    private func getLessonsForDownload(_ course: CourseModel, quality: Quality) -> [Downloader.Item] {
        let snapshot = ProgressTaskViewModel(total: course.lessons.count, completed: 0, courseName: course.name)
        progressSnapshot?(snapshot)
        var items: [Downloader.Item] = []
        for (index, lesson) in course.lessons.enumerated() {
            if let id = lesson.attributes?.video_identifier {
                let lessonsInfo = self.lessonsProvider.getLessonsInfo(id: id).filter { $0.quality == quality }
                let materials = getMaterialsForVideo(videoId: id, lessonPosition: index + 1)
                let filename = lesson.attributes?.name ?? UUID.init().uuidString
                let current = index + 1
                let finalFilename = "\(current)-\(filename)"
            
                if let track = self.getTrackForVideo(videoId: id, videoName: finalFilename) {
                    items.append(track)
                }
                    
                let updateSnapshot = ProgressTaskViewModel(total: course.lessons.count, completed: current, courseName: course.name)
                progressSnapshot?(updateSnapshot)
                let lessonsItems = lessonsInfo
                    .compactMap { $0.createDownloaderVideoItem(filename:  finalFilename)}
                items.append(contentsOf: lessonsItems)
                items.append(contentsOf: materials)
            }
        }
        return items
    }
    
    private func getTutorialForDownload(_ course: CourseModel, quality: Quality) -> [Downloader.Item] {
        guard let url = course.data?.links?.videoURL else {
            return []
        }
        let name = course.data?.courseName ?? UUID.init().uuidString
        let finalFilename = "1-\(name)"
        var materials: [Downloader.Item] = []
        let tutorials = self.lessonsProvider.getTutorialInfo(url: url)
            .enumerated()
            .filter { $0.element.quality == quality }
            .compactMap { $0.element.createDownloaderVideoItem(filename: finalFilename) }
        
        if let tutorialId = course.data?.tutorialId {
            materials = getMaterialsForVideo(videoId: tutorialId, lessonPosition: 1)
            if let track = getTrackForVideo(videoId: tutorialId, videoName: finalFilename) {
                materials.append(track)
            }
        }
        
        return tutorials + materials
    }
    
    private func getTrackForVideo(videoId: Int, videoName: String) -> Downloader.Item? {
        if let subtitles = self.lessonsProvider.getTrackForVideo(videoId: videoId) {
            return Downloader.Item(url: subtitles, filename: videoName, format: "vtt")
        }
        return nil
    }
    
    private func getMaterialsForVideo(videoId: Int, lessonPosition: Int) -> [Downloader.Item] {
        guard let videoInfo = self.lessonsProvider.getVideoInfo(videoId: videoId) else {
            return []
        }
        return videoInfo.downloaderAttachmentZipItems(lessonPosition: lessonPosition)
    }
    
    private func transformResponse(items: [Downloader.Item], courseName: String) -> [Lesson] {
        let groupedElements = items.group { (item) -> String in
            return item.fullname
        }
        
        let response = groupedElements.map { (key, data) -> Lesson in
            return Lesson(items: data, name: key, courseName: courseName)
        }
        
        return response
    }
}
