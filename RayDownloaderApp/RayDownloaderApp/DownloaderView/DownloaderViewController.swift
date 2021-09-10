//
//  DonwloaderViewController.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 07-09-21.
//

import UIKit
import PureLayout
import BussinnesLogic

class DownloaderViewController: UIViewController {

    let model: CourseFeedViewModel
    let useCase = RayWenderCourseDownloader()
    
    var courses: [CourseViewModel] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    lazy var progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progressTintColor = .blue
        progress.trackTintColor = .gray
        return progress
    }()
    
    init(model: CourseFeedViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setupView()
        self.configureUseCase()
        self.start()
    }
    
    
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(progressView)
        tableView.autoPinEdgesToSuperviewEdges()
        progressView.autoCenterInSuperview()
        progressView.autoSetDimensions(to: CGSize(width: 180, height: 40))
    }
    private func configureUseCase() {
        useCase.progressSnapshot = { (snapshot) in
            DispatchQueue.main.async {
                let progress = Float(snapshot.completed) / Float(snapshot.total)
                self.progressView.setProgress(progress, animated: true)
            }
        }
    }
    
    private func start() {
        guard let id = Int(model.id) else { return }
        useCase.getCourseLessons(courseId: id, quality: .sd) { (response) in
            DispatchQueue.main.async {
                self.showProgress(false)
            }
            switch response {
            case .success(let data):
                self.courses = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func showProgress(_ show: Bool = true) {
        progressView.isHidden = !show
    }
}


extension DownloaderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let item = courses[indexPath.row]
        cell.textLabel?.text = item.lessonName
        return cell
    }
    
}
