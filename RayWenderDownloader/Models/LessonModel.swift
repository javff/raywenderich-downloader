//
//  LessonModel.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/14/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation

struct LessonModel: Codable {
    let type: String
    let attributes: AttributesModel?
    let links: linkModel?
    
    var downloaderTutorialItem: Downloader.Item? {
        
        guard let links = links,
            let url = links.videoURL else {
                return nil
        }
        
        let fileName = self.courseName
        return Downloader.Item(url: url, filename: fileName, format: "mp4")
    }
    
    var tutorialId: Int? {
        return attributes?.video_identifier
    }
    
    var courseName: String {
        let name = attributes?.name?.formatPath()
        return name ?? UUID.init().uuidString
    }
}

struct linkModel: Codable {
    let video_download: String?
    
    var videoURL: URL? {
        guard let url = self.video_download?.replacingOccurrences(of: "http", with: "https") else {
            return nil
        }
        return URL(string: url)
    }
}
