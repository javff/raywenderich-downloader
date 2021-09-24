//
//  NibView.swift
//  
//
//  Created by Juan Andres Vasquez Ferrer on 24-09-21.
//


import UIKit

import Foundation
import UIKit

public class BaseNibView: UIView {

    convenience init() {
        self.init(frame: .zero)
        self.awakeFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewsFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewsFromNib()
    }

    func loadViewsFromNib() {
        let bundle = Bundle.module
        let nibName = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
        let nibPath = bundle.path(forResource: nibName, ofType: "nib")

        if FileManager.default.fileExists(atPath: nibPath ?? "") {
            if let view = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView {
                self.addSubview(view)
                self.pinViewToSuperview(view)
            }
        }
    }

    func pinViewToSuperview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
