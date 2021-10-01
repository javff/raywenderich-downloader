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
        tableView.allowsSelection = false
        return tableView
    }()
    
    let features: [String] = [
        "Listado de cursos ✅",
        "Paginación listado de cursos ✅",
        "Ver Detalle de un curso ✅",
        "Descargar un curso ✅",
        "Galeria de descarga ✅",
        "Abrir curso descargado en macOS ✅",
        "Abrir curso descargado en iOS 👷🏽‍♂️🔨",
        "Issue creación de carpeta una vez apretado el botón de descarga 👷🏽‍♂️🔨",
        "Reproducir un curso dentro de la app 👷🏽‍♂️🔨",
        "Search en listado de curso 👷🏽‍♂️🔨",
        "Habilitar descarga en HD 👷🏽‍♂️🔨",
        "Habilitar seteo de token de acceso custom 👷🏽‍♂️🔨",
        "Implementar Cache local con Realm 👷🏽‍♂️🔨",
        "Cache con KVS Usando Firebase 👷🏽‍♂️🔨",
        "Crear pantalla about US👷🏽‍♂️🔨"
    ]
    
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
        self.navigationItem.title = "Roadmap"
    }

}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return features.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = features[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
