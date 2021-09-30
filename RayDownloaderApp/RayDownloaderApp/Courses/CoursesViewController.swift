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
    let router: ListRouterProtocol
    let repository: CoursesRepositoryProtocol
    var courses: [CourseFeedViewModel] = []
    
    init(router: ListRouterProtocol, repository: CoursesRepositoryProtocol) {
        self.repository = repository
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
        self.fetch()
    }
    
    private func setupView() {
        courseView.dataSource = self
        courseView.delegate = self
    }
    
    private func fetch() {
        courseView.showLoading()
        repository.getFeed { (response) in
            self.courseView.stopLoading()
            switch response {
            case .success(let data):
                self.courses = data
                self.courseView.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension CoursesViewController: CoursesViewDataSource, CoursesViewDelegate {
    
    func getCourses() -> [CourseFeedViewModel] {
        return courses
    }
    
    func didSelect(item: CourseFeedViewModel) {
        router.navigate(route: .downloader(model: item))
    }
}
