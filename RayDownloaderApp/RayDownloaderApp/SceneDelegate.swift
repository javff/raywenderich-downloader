//
//  SceneDelegate.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 16-08-21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var router: AppRouter?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        guard let window = window else { return }
        self.router = AppRouter(window: window)
        self.router?.start()        
    }

}

