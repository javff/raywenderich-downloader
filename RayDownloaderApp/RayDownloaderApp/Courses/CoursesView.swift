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
    func lastCellWillAppear()
}

struct CourseFeedViewModel {
    let id: String
    let headline: String
    let platform: String
    let description: String
    let metaInfo: String
    let imageUrl: String
    let name: String
    let duration: Int
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
        setupView()
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
    
    func updateData() {
        let indexSet = IndexSet(integer: 0)
        self.tableView.reloadSections(indexSet, with: .fade)
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func startBottomSpinner() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
    }
    
    func stopBottomSpinner() {
        tableView.tableFooterView = UIView()
        tableView.tableFooterView?.isHidden = true
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
        let data = courses[indexPath.row]
        cell.bindView(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = courses[indexPath.row]
        delegate?.didSelect(item: item)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastCellIndex = courses.count - 2
        guard indexPath.row == lastCellIndex else { return }
        delegate?.lastCellWillAppear()
    }
}
