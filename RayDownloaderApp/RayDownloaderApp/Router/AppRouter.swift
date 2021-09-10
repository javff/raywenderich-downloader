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
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
    
    func navigate(route: Route) {
        switch route {
        case .downloader(model: let model):
            self.navigateToDownloader(model)
        
        }
    }
    
    private func navigateToDownloader(_ model: CourseFeedViewModel) {
        let controller = DownloaderViewController(model: model)
        self.navController?.pushViewController(controller, animated: true)
    }
}
