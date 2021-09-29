//
//  LibraryViewController.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 28-09-21.
//

import UIKit

class LibraryViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        return tableView
    }()
    let repository: LibraryRepositoryProtocol
    let libraryManager: LibraryManagerProtocol?
    var items: [LibraryItem] = []
    
    init(repository: LibraryRepositoryProtocol, libraryManager: LibraryManagerProtocol?) {
        self.repository = repository
        self.libraryManager = libraryManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.fetchItems()
    }
    
    private func setupView() {
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchItems() {
        repository.fetchItems { response in
            switch response {
            case .success(let data):
                self.items = data
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.items[indexPath.row]
        guard let url = item.url else { return }
        self.libraryManager?.openLibrary(url: url)
    }    
}
