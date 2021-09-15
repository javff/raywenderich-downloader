//
//  Lesson.swift
//  
//
//  Created by Juan Andres Vasquez Ferrer on 14-09-21.
//

import Foundation

public struct Lesson: DownloaddableItem {
    public var items: [Downloader.Item]
    public let lessonName: String
    public let courseName: String
    public var id: String = UUID.init().uuidString
        
    public init(items: [Downloader.Item], name: String, courseName: String) {
        self.items = items
        self.lessonName = name
        self.courseName = courseName
    }
}
