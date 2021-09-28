//
//  LibraryRepository.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 28-09-21.
//

import Foundation


protocol LibraryRepositoryProtocol: AnyObject {
    func fetchItems(completion:@escaping(Result<[LibraryItem], Error>) -> Void)
}


class LibraryRepository: LibraryRepositoryProtocol {
    
    let fileManager = FileManager.default
    let resourcePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    
    func fetchItems(completion: @escaping (Result<[LibraryItem], Error>) -> Void) {
        guard let resourcePath = self.resourcePath.first else { return }
        let items = (try? fileManager.contentsOfDirectory(atPath: resourcePath)) ?? []
        let result = items.map { LibraryItem(name: $0, url: URL(string: "\(resourcePath)/\($0)"))}
        completion(.success(result))
    }    
}
