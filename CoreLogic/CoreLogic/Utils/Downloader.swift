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
        
        var fullname: String {
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
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    private let items: [Item]
    private let folder: URL
    private var downloadCompleted = 0
    
    public var progress: (() -> Void)?
    
    public var startDownloadItem: ((Item) -> Void)?
    public var finishedAllDownloads: (() -> Void)?
    
    init(items: [Item], folder: URL) {
        self.items = items
        self.folder = folder
    }
    
    func start() {
        self.cancel()
        initQueue()
    }

    func cancel() {
        self.queue.cancelAllOperations()
    }
    
    private func initQueue() {
        
        let queue = OperationQueue()
        queue.name = "com.domain.app.networkqueue"
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: queue)
        
        let operations = items.map { (item) -> DownloaderItemOperation in
//            print("Init download \(item.filename).\(item.format)")
            self.startDownloadItem?(item)
            return DownloaderItemOperation(session: session, downloadTaskURL: item.url) { (tempDownloadedURL, _, _) in
                if let url = tempDownloadedURL {
                    self.saveDownloadedItem(item, localDestinationFile: url)
                }
            }
        }
        self.queue.addOperations(operations, waitUntilFinished: true)
        finishedAllDownloads?()
    }
    
    private func saveDownloadedItem(_ item: Item, localDestinationFile: URL) {
        if let urlData = NSData(contentsOf: localDestinationFile) {
            do {
                try urlData.write(to: item.getFilePath(saveIn: item.getFolderForFile(rootFolder: folder)), options: .atomic)
                self.downloadCompleted += 1
            }catch (let error) {
                print(error.localizedDescription)
            }
        }
    }
}
