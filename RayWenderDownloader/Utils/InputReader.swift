//
//  InputReader.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/16/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation


class InputReader {
    
    class func readURLInput() -> Int? {
        guard let stdURL = readLine(strippingNewline: true) else {
            return nil
        }
        let splitBySlash = stdURL.split(separator: "/")
        guard splitBySlash.count >= 1 else { return nil }
        let splitBySlashRef = splitBySlash.count == 1 ? splitBySlash[0] : splitBySlash.last
        guard let splitBySeparator = splitBySlashRef?.split(separator: "-") else { return nil }
        guard !splitBySeparator.isEmpty else { return nil }
        return Int(splitBySeparator[0])
    }
}
