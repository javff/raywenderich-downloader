//
//  LessonCell.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 13-09-21.
//

import UIKit

class LessonCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    func bindView(_ view: DownloaderViewModel) {
        titleLabel.text = view.lesson.lessonName
        if let progress = view.progress {
            self.showProgress(progress.fractionCompleted)
        }
    }
    
    func showProgress(_ progress: Double) {
        let progress: Float = Float(progress * 100)
        statusLabel.text = "\(progress)%"
    }

}
