//
//  main.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/13/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import BussinnesLogic

func main() {
   
    print("Enter URL of raywanderich course")
    guard let id = InputReader.readURLInput() else {
        print("please enter URL Valid")
        main()
        return
    }

    let useCase = RayWenderCourseDownloader()
    
    useCase.progressSnapshot = { (snapshot) in
        print("---------------------")
        print(snapshot.courseName)
        print(snapshot.completed)
        print("---------------------")
    }
    
    useCase.getCourseLessons(courseId: id, quality: .sd) { (response) in
        switch response {
        case .success(let data):
            
            data.forEach {
                useCase.startDownload(course: $0)
            }
        case .failure(let error):
            print(error)
        }
    }
}


main()
RunLoop.main.run()


