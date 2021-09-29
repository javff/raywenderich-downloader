//
//  AppRouter.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 10-09-21.
//

import Foundation
import UIKit

protocol TabRouterProtocol {
    func start()
    func navigate(route: TabRoute)
}

@available(macCatalyst 14.0, *)
class AppRouter: TabRouterProtocol {
        
    var tabController: UITabBarController?
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        let detailController = UINavigationController()
        let listRouter = ListRouter(navController: detailController)
        listRouter.start()
        
        let libraryController = UINavigationController()
        let libraryRouter = LibraryRouter(navController: libraryController)
        libraryRouter.start()
        
        tabController = UITabBarController()
        tabController?.viewControllers = [
            detailController,
            libraryController
        ]
        
        self.window.rootViewController = tabController
        self.window.makeKeyAndVisible()
        listRouter.start()
        libraryRouter.start()
    }
       
    
    func navigate(route: TabRoute) {

    }
}
