//
//  MenuViewController.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 26-09-21.
//

import UIKit
import PureLayout

class MenuViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        return tableView
    }()
    
    let options: [MenuOption] = MenuOption.allCases
    let router: TabRouterProtocol
    
    init(router: TabRouterProtocol) {
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
        self.router.navigate(route: selected.route)
    }
}
