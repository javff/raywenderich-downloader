//
//  LibraryRouter.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 28-09-21.
//

import Foundation
import UIKit

protocol LibraryRouterProtocol {
    func start()
}

class LibraryRouter: LibraryRouterProtocol {
   
    var navController: UINavigationController?
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func start() {
        let libraryManager: LibraryManagerProtocol
        
        if #available(macCatalyst 14.0, *) {
            libraryManager = LibraryCatalystManager()
        } else {
           libraryManager = LibraryiOSManager()
        }
        
        let repository = LibraryRepository()
        let libraryController = LibraryViewController(repository: repository, libraryManager: libraryManager)
        libraryController.title = "Library"
        self.navController?.setViewControllers([libraryController], animated: true)
    }
}
