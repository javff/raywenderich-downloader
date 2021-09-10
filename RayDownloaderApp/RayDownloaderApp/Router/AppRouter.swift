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
    func navigate()
}

class AppRouter: AppRouterProtocol {
    
    let window: UIWindow
    weak var navController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let controller = CoursesViewController(router: self)
        let navController = UINavigationController(rootViewController: controller)
        self.navController = navController
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
    
    func navigate() {
        
    }
}
