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

public class DownloaderDispacher: DownloaderDispacherProtocol {
    
    let downloader: Downloader
    
    public init(url: URL) {
        self.downloader = Downloader(folder: url)
    }
   
    public func startDownload(_ element: Downloader.Item) {
        downloader.startDownload(items: [element])
    }
}
