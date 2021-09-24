//
//  UIProgressTextView.swift
//  RayWenderDownloader
//
//  Created by Juan Andres Vasquez Ferrer on 8/13/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.

import UIKit


public class UIProgressTextView: BaseNibView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    public var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    public var proompt: String? {
        didSet {
            self.promptLabel.text = proompt
        }
    }
    
    public var progress: Float = 0 {
        didSet {
            self.progressView.setProgress(progress, animated: true)
            if progress == 1 { self.stopFeedbacks() }
        }
    }
    
    private var timer: Timer?
    
    public func showRandomFeedbacks(_ feedbacks: [String], internval: TimeInterval) {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: internval, repeats: true) {[weak self] timer in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let randomInt = Int.random(in: 1..<feedbacks.count)
                self.proompt = feedbacks[randomInt]
            }
        }
        
        self.timer?.fire()
    }
    
    public func stopFeedbacks() {
        self.proompt = nil
        self.timer?.invalidate()
    }
    
}
