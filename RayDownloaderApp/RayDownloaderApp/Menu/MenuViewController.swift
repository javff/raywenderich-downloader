//
//  MenuViewController.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 26-09-21.
//

import UIKit
import PureLayout
import SwiftUI

class MenuViewController: UIViewController {
        
    let router: TabRouterProtocol
    let hostingController = UIHostingController(rootView: MenuView())
    
    init(router: TabRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
        self.title = "Roadmap"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.autoPinEdgesToSuperviewEdges()
    }

}
