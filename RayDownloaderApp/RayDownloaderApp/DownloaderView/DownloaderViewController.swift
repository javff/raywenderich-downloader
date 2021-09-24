//
//  DonwloaderViewController.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 07-09-21.
//

import UIKit
import PureLayout
import BussinnesLogic
import UIProgressTextView

class DownloaderViewController: UIViewController {

    let model: CourseFeedViewModel
    var repository: LessonRepositoryProtocol
        
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: "LessonCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "LessonCell")
        return tableView
    }()
    
    lazy var progressView: UIProgressTextView = {
        let progress = UIProgressTextView()
        progress.title = "Por favor espere..."
        progress.showRandomFeedbacks([
            "Scraping...",
            "JAVFF",
            "to the moon 🍏 🚀",
            "🧨 🚗 💥",
            "Buscando info !!",
            "Compren ETH 😅 💰💰💰💰💰💰💰💰💰",
        ],
        internval: TimeInterval(2))
        progress.progress = 0
        return progress
    }()
    
    init(model: CourseFeedViewModel) {
        self.model = model
        let url = FileUtils.getDocumentsDirectoryForNewFile(folderName: model.id)
        let repository = LessonRepository(url: url)
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setupView()
        self.configureUseCase()
        self.start()
        
        self.repository.updated = {
            DispatchQueue.main.async {
                self.showProgress(false)
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(progressView)
        tableView.autoPinEdgesToSuperviewEdges()
        progressView.autoCenterInSuperview()
        progressView.autoSetDimensions(to: CGSize(width: 320, height: 150))
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
        guard let id = Int(model.id) else { return }
        repository.getCourseLessons(courseId: id, quality: .sd)
    }
    
    private func showProgress(_ show: Bool = true) {
        progressView.isHidden = !show
    }
}


extension DownloaderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repository.courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell") as? LessonCell else {
            fatalError("verifiry cell identifier")
        }

        
        cell.showProgress(repository.progress[indexPath.row])
        cell.titleLabel.text = repository.courses[indexPath.row].fullname
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let element = self.repository.courses[indexPath.row]
        self.repository.startDownload(course: element)
    }
}
