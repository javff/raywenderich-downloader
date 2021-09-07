//
//  DonwloaderViewController.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 07-09-21.
//

import UIKit
import BussinnesLogic

class DownloaderViewController: UIViewController {

    let url: URL
    let useCase = RayWenderCourseDownloader()
    
    var courses: [CourseViewModel] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    init(url: URL) {
        self.url = url
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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func configureUseCase() {
        useCase.progressSnapshot = { (snapshot) in
            print(snapshot.courseName)
            print(snapshot.completed)
        }
    }
    
    private func start() {
        guard let courseId = InputReader.getIdFromURL(stdURL: url.absoluteString) else { return }
                
        useCase.getCourseLessons(courseId: courseId, quality: .sd) { (response) in
            switch response {
            case .success(let data):
                self.courses.append(data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension DownloaderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.first?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let item = courses.first?.items[indexPath.row]
        cell.textLabel?.text = item?.fullname
        return cell
    }
    
}
