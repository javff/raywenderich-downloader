//
//  Route.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 10-09-21.
//

import Foundation

enum TabRoute {
    case library
    case list
    case about
    case settings
}

enum ListRoute {
    case downloader(model: CourseFeedViewModel)
}
