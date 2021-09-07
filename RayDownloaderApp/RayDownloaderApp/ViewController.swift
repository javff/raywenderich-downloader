//
//  ViewController.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 16-08-21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        view.endEditing(true)
        guard let text = textfield.text, let url = URL(string: text) else { return }
        let controller = DownloaderViewController(url: url)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

