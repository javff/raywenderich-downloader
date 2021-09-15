//
//  File.swift
//  
//
//  Created by Juan Andres Vasquez Ferrer on 14-09-21.
//

import Foundation


public protocol DownloaddableItem {
    var id: String { get }
    var items: [Downloader.Item] {get}
}
