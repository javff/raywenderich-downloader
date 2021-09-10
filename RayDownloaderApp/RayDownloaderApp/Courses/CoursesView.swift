//
//  CoursesView.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 10-09-21.
//

import Foundation
import UIKit
import PureLayout


protocol CoursesViewDataSource: AnyObject {
    func getCourses() -> [CourseFeedViewModel]
}

protocol CoursesViewDelegate: AnyObject {
    func didSelect(item: CourseFeedViewModel)
}

struct CourseFeedViewModel {
    let id: String
    let headline: String
    let platform: String
    let description: String
    let metaInfo: String
    let imageUrl: String
}

class CoursesView: UIView {
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.hidesWhenStopped = true
        return activity
    }()
    
    weak var delegate: CoursesViewDelegate?
    weak var dataSource: CoursesViewDataSource?
    
    
    var courses: [CourseFeedViewModel] {
        return dataSource?.getCourses() ?? []
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupCell()
        addSubview(tableView)
        addSubview(activityIndicator)
        tableView.autoPinEdgesToSuperviewEdges()
        activityIndicator.autoCenterInSuperview()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupCell() {
        let identifier = String(describing: CourseCell.self)
        let nib = UINib(nibName: identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
}

extension CoursesView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: CourseCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CourseCell else {
            fatalError("verifiy identifier")
        }
        let data = self.courses[indexPath.row]
        cell.bindView(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = self.courses[indexPath.row]
        self.delegate?.didSelect(item: item)
    }
}
