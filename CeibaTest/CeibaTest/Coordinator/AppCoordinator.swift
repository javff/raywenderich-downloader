//
//  AppCoordinator.swift
//  CeibaTest
//
//  Created by Juan Andres Vasquez Ferrer on 16-09-21.
//

import Foundation
import UIKit

enum Route {
    case detail(_ title: String)
}

protocol BaseCoordinator {
    func start() -> UIViewController
    func navigate(_ route: Route)
}


class AppCoordinator: BaseCoordinator {

    var navController: UINavigationController?
    
    func start() -> UIViewController {
        let repository = FakeHomeRepository()
        let presenter = HomePresenter(repository: repository, coordinator: self)
        let controller = HomeViewController(presenter: presenter)
        let navController = UINavigationController(rootViewController: controller)
        self.navController = navController
        return navController
    }
    
    func navigate(_ route: Route) {
        switch route {
        case .detail(let data):
            let controller = DetailController(detailTitle: data)
            self.navController?.pushViewController(controller, animated: true)
        }
    }
}
