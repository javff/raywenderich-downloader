//
//  AboutViewController.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 22-11-21.
//

import UIKit
import SwiftUI

class AboutViewController: UIViewController {

    let hostingController = UIHostingController(rootView: ProfileView())
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "About me"
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

