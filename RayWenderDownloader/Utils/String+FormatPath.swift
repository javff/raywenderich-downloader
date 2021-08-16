//
//  String+FormatPath.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/21/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation

extension String {
    
    func formatPath() -> String {
        return self.replacingOccurrences(of: " ", with: "-").replacingOccurrences(of: "/", with: "-").replacingOccurrences(of: ":", with: "-")
    }
}
