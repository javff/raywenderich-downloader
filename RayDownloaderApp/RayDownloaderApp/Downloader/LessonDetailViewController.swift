//
//  LessonDetailViewController.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 29-09-21.
//

import UIKit
import UIKit
import PureLayout
import BussinnesLogic
import UIProgressTextView
import Kingfisher

class LessonDetailViewController: UIViewController {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var extraInfoLabel: UILabel!
    @IBOutlet weak var extraInfoSubLabel: UILabel!
    
    private let model: CourseFeedViewModel
    private var repository: LessonRepositoryProtocol
    //TODO: Inyectar como dependencia para manejar ruta de descarga custom
    private let dispacher: DownloaderDispacherProtocol


    lazy var progressView: UIProgressTextView = {
        let progress = UIProgressTextView()
        progress.title = "Por favor espere..."
        progress.showRandomFeedbacks([
            "Scraping...",
            "JAVFF",
            "esto puede tardar 🍏 🚀",
            "🧨 🚗 💥",
            "Buscando info !!",
            " 🐈‍⬛ 🪞 🪜",
            " 🍀 🌈 👑"
        ],
        internval: TimeInterval(2))
        progress.progress = 0
        return progress
    }()
    
    
    init(model: CourseFeedViewModel, repository: LessonRepository) {
        self.model = model
        let sanitizeFolderName = model.name.replacingOccurrences(of: " ", with: "-")
        let url = FileUtils.getDocumentsDirectoryForNewFile(folderName: sanitizeFolderName)
        self.dispacher = DownloaderDispacher(url: url)
        let repository = repository
        self.repository = repository
        super.init(nibName: "LessonDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.bindView()
        self.configureUseCase()
        self.start()
        
//        self.repository.updated = {
//            DispatchQueue.main.async {
//                self.showProgress(false)
//                self.updateView()
//            }
//        }
    }
    
    private func updateView() {
        
    }
    
    private func setupView() {
        view.addSubview(progressView)
        progressView.autoCenterInSuperview()
        progressView.autoSetDimensions(to: CGSize(width: 320, height: 150))
        showProgress(false)
    }
    
    private func bindView() {
        self.navigationItem.title = model.headline
        self.descriptionLabel.text = model.description
        self.extraInfoLabel.text = model.duration.prettyDuration()
        self.extraInfoSubLabel.text = model.platform
        KF.url(URL(string: model.imageUrl)).set(to: coverImageView)
    }
    
    @IBAction func downloadAllButtonTapped() {
        repository.courses.flatMap { $0.items }.forEach {
            self.dispacher.startDownload($0)
        }
    }
    
    private func configureUseCase() {
        repository.progressSnapshot = { (snapshot) in
            DispatchQueue.main.async {
                let progress = Float(snapshot.completed) / Float(snapshot.total)
                self.progressView.progress = progress
            }
        }
    }
    
    private func start() {
//        guard let id = Int(model.id) else { return }
//        self.showProgress()
//        repository.getCourseLessons(courseId: id, quality: .sd)
    }
    
    private func showProgress(_ show: Bool = true) {
        progressView.isHidden = !show
//        self.navigationItem.rightBarButtonItem = !show ? self.downloadButton : nil
    }
}

//extension LessonDetailViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return repository.courses.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell") as? LessonCell else {
//            fatalError("verifiry cell identifier")
//        }
//
//        cell.titleLabel.text = repository.courses[indexPath.row].lessonName
//
//        return cell
//    }
//
//}
