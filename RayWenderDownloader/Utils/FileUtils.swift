//
//  FileUtils.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/17/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation


class FileUtils {
            
    class func getDocumentsDirectoryForNewFile(folderName: String) -> URL {
        self.createFolderIfNeeded(folderName: folderName)
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docURL = paths[0]
        let dataPath = docURL.appendingPathComponent(folderName)
        if !FileManager.default.fileExists(atPath: dataPath.absoluteString) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.absoluteString, withIntermediateDirectories: true, attributes: nil)
                return dataPath
            } catch {
                print(error.localizedDescription);
            }
        }
        return dataPath
    }
    
    private class func createFolderIfNeeded(folderName: String, subFolderName: String? = nil) {
        let docURL = getDirectory(folder: subFolderName)
        let dataPath = docURL.appendingPathComponent(folderName)
        if !FileManager.default.fileExists(atPath: dataPath.absoluteString) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.absoluteString, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription);
            }
        }
    }
    
    private class func getDirectory(folder: String? = nil) -> URL {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        var docURL = URL(string: documentsDirectory)!
        if let folder = folder {
            docURL = docURL.appendingPathComponent(folder)
        }
        return docURL
    }
    
     class func createFolderIfNeeded(rootFolder: URL, newFolderName: String) -> URL {
        let rootFolderName = rootFolder.lastPathComponent
        self.createFolderIfNeeded(folderName: newFolderName, subFolderName: rootFolderName)
        let dataPath = rootFolder.appendingPathComponent(newFolderName)
        if !FileManager.default.fileExists(atPath: dataPath.absoluteString) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.absoluteString, withIntermediateDirectories: true, attributes: nil)
                return dataPath
            } catch {
                print(error.localizedDescription);
                return rootFolder
            }
        }
        return dataPath
    }
}
