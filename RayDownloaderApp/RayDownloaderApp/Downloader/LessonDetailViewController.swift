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

    var lessons: [Lesson] = []

    lazy var progressView: UIProgressTextView = {
        let progress = UIProgressTextView()
        progress.layer.cornerRadius = 15
        progress.layer.masksToBounds = true
        progress.title = "Por favor espere..."
        progress.showRandomFeedbacks([
            "Scraping...",
            "JAVFF",
            "esto puede tardar 😅 🚀",
            "🧨 🚗 💥",
            "Buscando info !!",
            " 🐈‍⬛ 🪞 🪜",
            " 🍀 🌈 👑"
        ],
        internval: TimeInterval(2))
        progress.progress = 0
        return progress
    }()
    
    lazy var visualEffect: UIVisualEffectView = {
        let effectView = UIVisualEffectView()
        effectView.effect = nil
        return effectView
    }()
    
    lazy var containerProgressView: UIView = {
        let view = UIView()
        
        view.addSubview(visualEffect)
        view.addSubview(progressView)

        progressView.autoCenterInSuperview()
        visualEffect.autoPinEdgesToSuperviewEdges()

        progressView.autoSetDimensions(to: CGSize(width: 320, height: 150))
        view.isHidden = true
        return view
    }()
    
    init(model: CourseFeedViewModel, repository: LessonRepository) {
        self.model = model
        let sanitizeFolderName = model.name.replacingOccurrences(of: " ", with: "-")
        let url = FileUtils.getDocumentsDirectoryForNewFile(folderName: sanitizeFolderName)
        self.dispacher = DownloaderDispacher(url: url)
        let repository = repository
        self.repository = repository
        super.init(nibName: "LessonDetailViewController", bundle: nil)
        self.dispacher.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.bindView()
        self.configureUseCase()
    }
    
    private func updateView() {
        
    }
    
    private func setupView() {
        view.addSubview(containerProgressView)
        containerProgressView.autoPinEdgesToSuperviewEdges()
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
        self.scrapingStart()
    }
    
    internal func startDownload() {
        let items = lessons.flatMap { $0.items }
        self.dispacher.startDownload(items)
    }
    
    private func configureUseCase() {
        repository.progressSnapshot = { (snapshot) in
            DispatchQueue.main.async {
                let progress = Float(snapshot.completed) / Float(snapshot.total)
                self.progressView.progress = progress
            }
        }
    }
    
    private func scrapingStart() {
        guard let id = Int(model.id) else { return }
        self.showProgress()
        
        repository.getCourseLessons(courseId: id, quality: .sd) { response in
            switch response {
            case .success(let data):
                self.lessons = data
                self.startDownload()
            case .failure:
                //TODO: Handler error
                break
            }
        }
    }
    
    private func showProgress(_ show: Bool = true) {
        UIView.animate(withDuration: 0.25) {
            self.progressView.isHidden = !show
            self.containerProgressView.isHidden = !show
            self.visualEffect.effect = UIBlurEffect(style: UIBlurEffect.Style.prominent)
        }
    }
}

extension LessonDetailViewController: DownloaderDispacherDelegate {

    func dispacherStartDownload() {
        self.progressView.resetProgress()
        self.progressView.title = "Descargando Archivos"
    }
    
    func dispacherFinishedDownload() {
        self.showProgress(false)
        //TODO: - Mostrar descarga
    }
    
    func downloaderDispacher(_ dispacher: DownloaderDispacher, progress: Double, completed: Int, total: Int) {
        self.progressView.prompt = "\(completed) / \(total)"
        self.progressView.progress = Float(progress)
    }
}
