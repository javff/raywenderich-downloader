//
//  Downloader.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/14/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation


public class Downloader {
    
    public struct Item {
        let url: URL
        let filename: String
        let format: String
        
        public var progress: Double = 0
                        
        public var fullname: String {
            return filename.formatPath()
        }
    
        func getFilePath(saveIn folder: URL) -> URL {
            return folder.appendingPathComponent(fullname).appendingPathExtension(format)
        }
        
        func getFolderForFile(rootFolder: URL) -> URL {
            return FileUtils.createFolderIfNeeded(rootFolder: rootFolder, newFolderName: fullname)
        }
    }
    
    private let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 10
        return queue
    }()
    
    private let downloadSession: URLSession = {
        let queue = OperationQueue()
        queue.name = "com.domain.app.networkqueue"
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: queue)
        return session
    }()
    
    public var progressHandler: ((Double, Int, Int) -> Void)?
    
    public var finishHandler: (() -> Void)?
    
    var observation: NSKeyValueObservation?

    private let folder: URL
    
    init(folder: URL) {
        self.folder = folder
    }

    func cancel() {
        self.queue.cancelAllOperations()
    }
    
    func startDownload(items: [Item]) {
        let operations = items.enumerated().map { (index, item) -> DownloaderItemOperation in
            let op = DownloaderItemOperation(session: self.downloadSession, downloadTaskURL: item.url) { (tempDownloadedURL, _, _) in
                if let url = tempDownloadedURL {
                    self.saveDownloadedItem(item, localDestinationFile: url)
                }
            }
            return op
        }
        
        self.queue.addOperations(operations, waitUntilFinished: false)
        
        observation = self.queue.observe(\.operationCount) { operationQueue, _ in
            let progress: Double = 1 - Double(Double(operationQueue.operationCount) / Double(items.count))
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let total = items.count
                let completed = items.count - operationQueue.operationCount
                self.progressHandler?(progress, completed, total)
                
                if total == completed {
                    self.finishHandler?()
                }
            }
        }
    }
    
    private func saveDownloadedItem(_ item: Item, localDestinationFile: URL) {
        if let urlData = NSData(contentsOf: localDestinationFile) {
            do {
                try urlData.write(to: item.getFilePath(saveIn: item.getFolderForFile(rootFolder: folder)), options: .atomic)
            }catch (let error) {
                print(error.localizedDescription)
            }
        }
    }
}
