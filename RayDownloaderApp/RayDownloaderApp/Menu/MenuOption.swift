//
//  MenuOption.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 28-09-21.
//

import Foundation

enum MenuOption: String, CaseIterable {
    case list
    case library
    case settings
    case about
    
    var route: TabRoute {
        switch self {
        case .library:
            return .library
        case .list:
            return .list
        case .settings:
            return .settings
        case .about:
            return .about
        }
    }
}
