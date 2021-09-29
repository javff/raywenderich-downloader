//
//  DownloaderDispacher.swift
//  
//
//  Created by Juan Andres Vasquez Ferrer on 14-09-21.
//

import Foundation

public protocol DownloaderDispacherProtocol: AnyObject {
    func startDownload(_ elements: [Downloader.Item])
    var delegate: DownloaderDispacherDelegate? { get set }

}

public protocol DownloaderDispacherDelegate: AnyObject {
    func dispacherStartDownload()
    func dispacherFinishedDownload()
    func downloaderDispacher(_ dispacher: DownloaderDispacher, progress: Double, completed: Int, total: Int)
}

public class DownloaderDispacher: DownloaderDispacherProtocol {
    
    let downloader: Downloader
    weak public var delegate: DownloaderDispacherDelegate?
    
    public init(url: URL) {
        self.downloader = Downloader(folder: url)
        
        self.downloader.progressHandler = { [weak self] (progres, completed, total) in
            guard let self = self else { return }
            self.delegate?.downloaderDispacher(self, progress: progres, completed: completed, total: total)
        }
        
        self.downloader.finishHandler = { [weak self] in
            guard let self = self else { return }
            self.delegate?.dispacherFinishedDownload()
        }
    }
   
    public func startDownload(_ elements: [Downloader.Item]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.delegate?.dispacherStartDownload()
        }
        downloader.startDownload(items: elements)
    }
}
