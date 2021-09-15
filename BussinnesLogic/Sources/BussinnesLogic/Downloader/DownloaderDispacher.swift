//
//  DownloaderDispacher.swift
//  
//
//  Created by Juan Andres Vasquez Ferrer on 14-09-21.
//

import Foundation

public protocol DownloaderDispacherProtocol: AnyObject {
    func startDownload(_ element: Downloader.Item)
}

public protocol DownloaderDispacherDelegate: AnyObject {
    func downloadProgress(_ element: DownloaddableItem, progress: Progress, current: Int, remaining: Int, total: Int)
}

public class DownloaderDispacher: DownloaderDispacherProtocol {
    
    public weak var delegate: DownloaderDispacherDelegate?
    let downloader: Downloader
    
    public init(url: URL) {
        self.downloader = Downloader(folder: url)
    }
   
    public func startDownload(_ element: Downloader.Item) {
        downloader.startDownload(items: [element])
    }
}
