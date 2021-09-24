//
//  ViewController.swift
//  CeibaTest
//
//  Created by Juan Andres Vasquez Ferrer on 16-09-21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


class DetailController: UIViewController {
    
    let detailTitle: String
    
    init(detailTitle: String) {
        self.detailTitle = detailTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        self.navigationItem.prompt = detailTitle
        // Do any additional setup after loading the view.
    }


}

