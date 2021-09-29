//
//  DownloaderOperation.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/17/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation

class DownloaderItemOperation: Operation {
    
    private var task: URLSessionDownloadTask!
    
    enum OperationState {
        case ready
        case executing
        case finished
    }
    
    private var state : OperationState = .ready {
        willSet {
            self.willChangeValue(forKey: "isExecuting")
            self.willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            self.didChangeValue(forKey: "isExecuting")
            self.didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isReady: Bool { return state == .ready }
    override var isExecuting: Bool { return state == .executing }
    override var isFinished: Bool { return state == .finished }
        
    override func start() {
        if(self.isCancelled) {
            state = .finished
            return
        }
        state = .executing
        self.task.resume()
    }
    
    override func cancel() {
        super.cancel()
        // cancel the downloading
        self.task.cancel()
    }
    
    init(session: URLSession, downloadTaskURL: URL, completionHandler: ((URL?, URLResponse?, Error?) -> Void)?) {
        super.init()
        
        task = session.downloadTask(with: downloadTaskURL, completionHandler: { [weak self] (localURL, response, error) in
            
            if let completionHandler = completionHandler {
                completionHandler(localURL, response, error)
            }
            
            self?.state = .finished
        })        
    }
}
