//
//  StreamModel.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/19/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation

struct StreamModel: Codable {
    let data: StreamDataModel?
}

struct StreamDataModel: Codable {
    let attributes: AttributesModel?
}
