//
//  CoursesViewController.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 10-09-21.
//

import UIKit
import PureLayout

class CoursesViewController: UIViewController {
    
    let courseView = CoursesView()
    let router: AppRouterProtocol
    
    init(router: AppRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = courseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        courseView.dataSource = self
        title = "Courses"
    }
}

extension CoursesViewController: CoursesViewDataSource {
    func getCourses() -> [CourseFeedViewModel] {
        return [
            CourseFeedViewModel(headline: "CoreHaptics",
                                platform: "IOS & Swift",
                                description: "learn how to create and play hatic pattern, synchornize audio with haptic events, and create dynamic haptic pattern that respond to external ..",
                                metaInfo: "Sep 06 2021 .Video course (15 min)")
        ]
    }
}
