//
//  MenuViewController.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 26-09-21.
//

import UIKit
import PureLayout

class MenuViewController: UIViewController {
    
    enum Option: String, CaseIterable {
        case list
        case library
        case settings
        case about
    }
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        return tableView
    }()
    
    let options: [Option] = Option.allCases
    let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        tableView.delegate = self
        tableView.dataSource = self
    }


    
    private func setupView() {
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
        self.navigationItem.title = "Menu"
    }

}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = options[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = self.options[indexPath.row]
        
        switch selected {
        case .library:
            self.router.navigate(route: .library)
        default:
            break
        }
    }
}
