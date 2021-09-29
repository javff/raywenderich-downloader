//
//  SceneDelegate.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 16-08-21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var router: TabRouterProtocol?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        guard let window = window else { return }
       
        if #available(macCatalyst 14.0, *) {
            self.router = AppRouter(window: window)
        } else {
            // Fallback on earlier versions
        }
        self.router?.start()
    }

}

