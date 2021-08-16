//
//  main.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/13/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation



func main() {
   
    print("Enter URL of raywanderich course")
    guard let id = InputReader.readURLInput() else {
        print("please enter URL Valid")
        main()
        return
    }

    let useCase = RayWenderCourseDownloader()
    useCase.downloadFullCourseUsingId(courseId: id, quality: .sd)    
}


main()
RunLoop.main.run()


