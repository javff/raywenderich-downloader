//
//  BaseService.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/13/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation

class BaseService: NSObject {
    
    var baseURL: String {
        return "https://api.raywenderlich.com/api"
    }
    let authToken = "Token eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkNWMwOTM2MC1kYjM1LTExZWEtODY0Ny0wMzRhZWQ2NDExMDIiLCJpYXQiOjE1OTczMzkyOTR9.f182UvYcemEA79WbjAeVKOY5ngjuwENhLyZ1znRpX58"

    let rmToken = "8a35bd79bca945f1991da36304d9c7f4"

    func getUrlRequest(with url: URL) -> URLRequest? {
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(self.authToken, forHTTPHeaderField: "Authorization")
        urlRequest.addValue(self.rmToken, forHTTPHeaderField: "RW-App-Token")
        return urlRequest
    }
    
    var session: URLSession {
        let queue = OperationQueue()
        queue.name = "com.domain.app.networkqueue"
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue: queue)
    }
    
}

extension BaseService: URLSessionDelegate, URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        completionHandler(nil)
    }
}
