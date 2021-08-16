//
//  CustomErrorModel.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/19/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation


struct CustomErrorModel: Error {
    
    let reason: String
    
    var localizedDescription: String {
        return reason
    }
}
