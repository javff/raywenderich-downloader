//
//  AttributesModel.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/14/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation


struct AttributesModel: Codable {
    let video_identifier: Int?
    let url: String?
    let kind: String?
    let name: String?
}
