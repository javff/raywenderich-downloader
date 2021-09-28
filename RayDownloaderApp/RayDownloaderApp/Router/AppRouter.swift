//
//  AppRouter.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 10-09-21.
//

import Foundation
import UIKit

protocol AppRouterProtocol {
    func start()
    func navigate(route: Route)
}

class AppRouter: AppRouterProtocol {
    
    let window: UIWindow
    weak var navController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let repository = CoursesRepository()
        let controller = CoursesViewController(router: self, repository: repository)
        let navController = UINavigationController(rootViewController: controller)
        self.navController = navController
//        window.rootViewController = navController
//        window.makeKeyAndVisible()
        
        if #available(macCatalyst 14.0, *) {
            let splitViewController = UISplitViewController(style: .doubleColumn)
            splitViewController.primaryBackgroundStyle = .sidebar
            splitViewController.preferredDisplayMode = .twoBesideSecondary

            let viewController =  UINavigationController(rootViewController:  MenuViewController(router: self))
            splitViewController.setViewController(viewController, for: .primary)
            splitViewController.setViewController(navController, for: .secondary)
            self.window.rootViewController = splitViewController
            self.window.makeKeyAndVisible()
        } else {
            // Fallback on earlier versions
        }
       
        
    }
    
    func navigate(route: Route) {
        switch route {
        case .downloader(model: let model):
            self.navigateToDownloader(model)
        
        case .library:
            self.navigateToLibrary()
        }
    }
    
    private func navigateToDownloader(_ model: CourseFeedViewModel) {
        let controller = DownloaderViewController(model: model)
        self.navController?.pushViewController(controller, animated: true)
    }
    
    private func navigateToLibrary() {
        let libraryManager: LibraryManagerProtocol
        
        if #available(macCatalyst 14.0, *) {
            libraryManager = LibraryCatalystManager()
        } else {
            libraryManager = LibraryiOSManager()
        }
        let repository = LibraryRepository()
        let libraryController = LibraryViewController(repository: repository, libraryManager: libraryManager)
        self.navController?.setViewControllers([libraryController], animated: true)
    }
}
