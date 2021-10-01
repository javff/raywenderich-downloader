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
                
        if #available(macCatalyst 14.0, *) {
            let menuController = MenuViewController(router: self)
            let splitController = UISplitViewController(style: .doubleColumn)
            splitController.setViewController(tabController, for: .secondary)
            splitController.setViewController(menuController, for: .primary)
            self.window.rootViewController = splitController
            self.window.makeKeyAndVisible()
        } else {
            self.window.rootViewController = tabController
            self.window.makeKeyAndVisible()
        }
    }
       
    
    func navigate(route: TabRoute) {

    }
}
