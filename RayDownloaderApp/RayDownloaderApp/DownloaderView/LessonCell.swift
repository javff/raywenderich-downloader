//
//  LessonCell.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 13-09-21.
//

import UIKit

class LessonCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    func bindView(_ view: DownloaderViewModel) {
        titleLabel.text = view.lesson.lessonName
        if let progress = view.progress {
            self.showProgress(progress.fractionCompleted)
        } else {
            self.hideProgress()
        }
    }
    
    func showProgress(_ progress: Double) {

        let progress: Float = Float(progress * 100)
        self.hideProgress(false)
        statusLabel.text = "\(progress)%"
        progressView.setProgress(progress, animated: true)
    }

    
    private func hideProgress(_ hide: Bool = true) {
        self.progressView.isHidden = hide
    }
}
