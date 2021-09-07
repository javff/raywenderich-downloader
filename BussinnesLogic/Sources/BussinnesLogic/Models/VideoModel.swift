//
//  VideoModel.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/17/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation

public struct VideoInfoModel: Codable {
    let video: VideoModel?
    
    func downloaderAttachmentZipItems(lessonPosition: Int) -> [Downloader.Item] {
        let zipAttachements = self.video?.zipAttachments ?? []
        let name = self.video?.name?.formatPath() ?? UUID.init().uuidString
        return zipAttachements
            .enumerated()
            .compactMap{$0.element.createDownloaderAttachmentZipItem(with: "\(lessonPosition)-\(name)")}
    }
}

public struct VideoModel: Codable {
    let attributes: AttributesModel?
    let attachments: [AttachmentModel]?
    let name: String?

    
    func createDownloaderVideoItem(filename: String? = nil) -> Downloader.Item? {
        guard let attributes = attributes else {
            return nil
        }
        
        guard let url = attributes.url, let downloadURL = URL(string: url) else {
            return nil
        }
        let finalFilename = filename ?? self.attributes?.name ?? UUID.init().uuidString
        return Downloader.Item(url: downloadURL, filename: finalFilename, format: "mp4")
    }
    
    var zipAttachments: [AttachmentModel] {
        guard let attachments = attachments else { return [] }
        return attachments.filter { $0.kind == "materials" }
    }
    
    var quality: Quality {
        return attributes?.kind == "sd_video_file" ? .sd : .hd
    }
}

struct AttachmentModel: Codable {
    let id: Int
    let url: String
    let kind: String
    
    func createDownloaderAttachmentZipItem(with filename: String) -> Downloader.Item? {
        guard let url = URL(string: url) else { return nil }
        return Downloader.Item(url: url, filename: filename, format: "zip")
    }
}

struct DownloadModel: Codable {
    let data: [VideoModel]
}
