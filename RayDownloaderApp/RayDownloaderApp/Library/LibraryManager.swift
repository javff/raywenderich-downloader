//
//  LibraryManager.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 28-09-21.
//

import Foundation
import Dynamic

protocol LibraryManagerProtocol {
    func openLibrary(url: URL)
}


@available(macOS 14.0, *)
class LibraryCatalystManager: LibraryManagerProtocol {
  
    func openLibrary(url: URL) {
        let url = URL(fileURLWithPath: url.absoluteString)
        Dynamic.NSWorkspace.sharedWorkspace.activateFileViewerSelectingURLs([url])
    }
}


class LibraryiOSManager: LibraryManagerProtocol {
    func openLibrary(url: URL) {
        //TODO: open library in ios os
    }
}
