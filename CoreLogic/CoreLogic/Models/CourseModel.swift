//
//  CourseModel.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/14/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation

struct CourseModel: Codable {
    var included: [LessonModel] = []
    let data: LessonModel?
    var lessons: [LessonModel] {
        return included.filter{ $0.type == "contents" }
    }
    
    var name: String {
        return data?.courseName ?? UUID.init().uuidString
    }
}


public enum Quality: String {
    case sd = "sd_video_file"
    case hd = "hd_video_file"
}
