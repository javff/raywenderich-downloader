//
//  HomeViewController.swift
//  CeibaTest
//
//  Created by Juan Andres Vasquez Ferrer on 16-09-21.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func showLoading()
    func stopLoading()
    func renderTitles(_ titles: [String])
    func showError(_ error: Error)
}

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let presenter: HomePresenterProtocol
    var titles: [String] = []

    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "HomeViewController", bundle: nil)
        presenter.bindView(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidload()
        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func buttonTapped(_ sender: Any) {
   
    }
    
}

extension HomeViewController: HomeViewProtocol {

    func showLoading() {
        indicator.startAnimating()
    }
    
    func stopLoading() {
        indicator.stopAnimating()
    }
    
    func renderTitles(_ titles: [String]) {
        self.titles = titles
        self.tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        //TODO:
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = self.titles[indexPath.row]
        self.presenter.goToDetail(title: title)
    }
    
    
}
