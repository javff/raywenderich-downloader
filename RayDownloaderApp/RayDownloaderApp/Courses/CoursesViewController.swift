//
//  CoursesViewController.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 10-09-21.
//

import UIKit

class CoursesViewController: UIViewController {
    
    let courseView = CoursesView()
    let router: ListRouterProtocol
    let repository: CoursesRepositoryProtocol
    lazy var searchContext: RemoteSearchContext<CourseFeedViewModel> = {
        let context = RemoteSearchContext<CourseFeedViewModel>(
            placeholder: "Search Courses",
            viewController: self,
            debounceInterval: 0.5
        )
        context.delegate = self
        context.updateChanges = { [weak self] in
            guard let self = self else { return }
            self.courseView.updateData()
        }
        return context
    }()
    
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
        navigationItem.title = "Courses"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetch()
    }
    
    private func setupView() {
        courseView.dataSource = self
        courseView.delegate = self
        searchContext.configure()
    }
    
    private func fetch() {
        courseView.showLoading()
        repository.getFeed(query: nil) { (response) in
            self.courseView.stopLoading()
            switch response {
            case .success(let data):
                self.searchContext.items = data
                self.courseView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchNextPage() {
        courseView.startBottomSpinner()
        repository.getNextPage { response in
            self.courseView.stopBottomSpinner()
            switch response {
            case .success(let data):
                self.searchContext.items += data
                self.courseView.reloadData()
            case .failure:
                break
            }
        }
    }
}

extension CoursesViewController: CoursesViewDataSource, CoursesViewDelegate {
    
    func getCourses() -> [CourseFeedViewModel] {
        return searchContext.currentItems
    }
    
    func didSelect(item: CourseFeedViewModel) {
        router.navigate(route: .lessonDetail(model: item))
    }
    
    func lastCellWillAppear() {
        guard !searchContext.isFilterApplied else {
            courseView.stopBottomSpinner()
            return
        }
        fetchNextPage()
    }
}

extension CoursesViewController: RemoteSearchContextDelegate {
    func searchItems(with text: String) {
        courseView.showLoading()
        repository.getFeed(query: text) { response in
            self.courseView.stopLoading()
            self.searchContext.updater?(response)
        }
    }
}
