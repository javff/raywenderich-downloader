//
//  File.swift
//  
//
//  Created by Juan Andres Vasquez Ferrer on 10-09-21.
//

import Foundation

extension Sequence {
   func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
       var categories: [U: [Iterator.Element]] = [:]
       for element in self {
           let key = key(element)
           if case nil = categories[key]?.append(element) {
               categories[key] = [element]
           }
       }
       return categories
   }
}
