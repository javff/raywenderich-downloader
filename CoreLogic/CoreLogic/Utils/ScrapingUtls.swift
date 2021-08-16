//
//  ScrapingUtls.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/19/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation


class ScrapingUtils {
    
    class func getSubtitleUrl(textContent: String) -> URL? {
        
        let info = textContent.split(separator: "\n")

        if info.count <= 2 {
            return nil
        }

        let infoEx = info[2]

        let spliting = infoEx.split(separator: ",").compactMap { (element) -> String? in
            var pp = element.split(separator: "=")
            if pp.count <= 1 { return nil }
            pp.remove(at: 0)
            return String(pp.joined(separator: "=").replacingOccurrences(of: "\"", with: ""))
        }
        let url = spliting.filter {$0.contains("https")}.first
        
        guard let safeUrl = url else {
            return nil
        }
        
        return URL(string: safeUrl)
    }
    
    class func getPathForDownloadTextTrack(textContent: String) -> String? {
        let info = textContent.split(separator: "\n")
        let content = info.filter {$0.contains("texttrack")}.first
        guard let path = content else {
            return nil
        }
        guard let textTrack = path.split(separator: "/").last?.replacingOccurrences(of: "\"", with: "") else {
            return nil
        }
        return String(textTrack)
    }
    
    class func createTextTrackDownload(content: String, url: URL) -> URL? {
        let tmpUrl = url.deletingLastPathComponent()
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .appendingPathComponent("texttrack")
            
        let result = tmpUrl.absoluteString.split(separator: "?")[0]
        return URL(string: result + "/\(content)")
    }
}
