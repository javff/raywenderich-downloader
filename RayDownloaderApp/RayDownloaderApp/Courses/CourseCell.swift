//
//  CourseCell.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 10-09-21.
//

import Foundation
import UIKit
import Kingfisher

class CourseCell: UITableViewCell {
    
    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var metaInfo: UILabel!
    @IBOutlet weak var contentDescription: UILabel!
    
    func bindView(_ data: CourseFeedViewModel) {
        headline.text = data.headline
        subtitle.text = data.platform
        contentDescription.text = data.description
        metaInfo.text = data.metaInfo
        KF.url(URL(string: data.imageUrl)).set(to: contentImageView)
    }
}
