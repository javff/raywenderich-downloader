//
//  Int+ConvertionTime.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 29-09-21.
//

import Foundation


extension Int {
    
    func secondsToHoursMinutesSeconds () -> (Int, Int, Int) {
      return (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
    }
    
    func prettyDuration() -> String {
        let (hours, minutes, _) = self.secondsToHoursMinutesSeconds()
        if hours > 0 {
            return " \(hours) hours \(minutes) minutes aprox"
        }
        
        return "\(minutes) minutes aprox"
    }
}
