//
//  LessonCell.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 13-09-21.
//

import UIKit

class LessonCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    func bindView(_ view: DownloaderViewModel) {
        titleLabel.text = view.lesson.lessonName
    }

}
