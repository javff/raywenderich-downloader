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
    func getCourseLessons(courseId: Int, quality: Quality, completion: @escaping(Result<[Lesson], Error>) -> Void)
}


class LessonRepository: LessonRepositoryProtocol {
    
    private let useCase = RayWenderCourseDownloader()
    var courses: [Lesson] = []
    var downloadProgress: [Double] = []
    var updated: (() -> Void)?
    
    var progressSnapshot: ((ProgressTaskViewModel) -> Void)? {
        didSet {
            useCase.progressSnapshot = self.progressSnapshot
        }
    }

    func getCourseLessons(courseId: Int, quality: Quality, completion: @escaping (Result<[Lesson], Error>) -> Void) {
        useCase.getCourseLessons(courseId: courseId, quality: quality, completion: completion)
    }
}
