//
//  ListRouter.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 28-09-21.
//

import Foundation
import UIKit

protocol ListRouterProtocol {
    func start()
    func navigate(route: ListRoute)
}

class ListRouter: ListRouterProtocol {
   
    var navController: UINavigationController?
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func start() {
        let repository = CoursesRepository()
        let viewController = CoursesViewController(router: self, repository: repository)
        self.navController?.setViewControllers([viewController], animated: true)
    }
    
    func navigate(route: ListRoute) {
        if case let .downloader(model: model) = route {
            self.navigateToDownloader(model)
        }
    }
    
    private func navigateToDownloader(_ model: CourseFeedViewModel) {
        let repository = LessonRepository()
        let controller = LessonDetailViewController(model: model, repository: repository)
        self.navController?.pushViewController(controller, animated: true)
    }
}
