//
//  LessonRepository.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 13-09-21.
//

import Foundation
import BussinnesLogic


protocol LessonRepositoryProtocol {
    var progressSnapshot: ((ProgressTaskViewModel) -> Void)? { get set }
    func getCourseLessons(courseId: Int, quality: Quality)
    func startDownload(course: Downloader.Item)
    var courses: [Downloader.Item] { get set }
    var updated: (() -> Void)? { get set }
}

struct DownloaderViewModel {
    let lesson: Lesson
    var progress: Progress?
    var current: Int
    var remaining: Int
    var total: Int
    
}

class LessonRepository: LessonRepositoryProtocol {
    
    private let useCase = RayWenderCourseDownloader()
    private let dispacher: DownloaderDispacher
    var courses: [Downloader.Item] = []
    
    var updated: (() -> Void)?
    
    init(url: URL) {
        self.dispacher = DownloaderDispacher(url: url)
    }
    
    var progressSnapshot: ((ProgressTaskViewModel) -> Void)? {
        didSet {
            useCase.progressSnapshot = self.progressSnapshot
        }
    }
    
    func getCourseLessons(courseId: Int, quality: Quality) {
        useCase.getCourseLessons(courseId: courseId, quality: quality) { (response) in
            switch response {
            case .success(let data):
                self.courses = data.flatMap { $0.items }
                self.updated?()
            case .failure:
                break
            }
        }
    }
    
    func startDownload(course: Downloader.Item) {
        self.dispacher.startDownload(course)
    }
}
