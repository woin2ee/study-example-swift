//
//  ViewController.swift
//  InteractiveProgressBar
//
//  Created by Jaewon on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {

    let timeInterval: Double = 1
    let progressInterval: Int = 1
    
    let min: Int = 0
    let max: Int = 198
    
    var downloadProgress: Int = 0
    var timer: Timer?
    
    let barWidth: CGFloat = 340
    let barHeight: CGFloat = 5
    
    lazy var progressBar: UIProgressView = {
        let bar = UIProgressView(progressViewStyle: .default)
        // Set Color
        bar.trackTintColor = .systemGray4
        bar.progressTintColor = .blue
        
        // Set progress
        bar.progress = Float(min)

        bar.layer.cornerRadius = barHeight / 2
        bar.clipsToBounds = true
        
        return bar
    }()
    
    lazy var progressForwardButton: UIButton = {
        let button = UIButton(
            configuration: UIButton.Configuration.filled(),
            primaryAction: UIAction { _ in
                self.increaseProgress()
            }
        )
        button.setTitle("Forward", for: .normal)
        return button
    }()
    
    lazy var progressBackwardButton: UIButton = {
        let button = UIButton(
            configuration: UIButton.Configuration.filled(),
            primaryAction: UIAction { _ in
                self.decreaseProgress()
            }
        )
        button.setTitle("Backward", for: .normal)
        return button
    }()
    
    lazy var stopButton: UIButton = {
        let button = UIButton(
            configuration: UIButton.Configuration.filled(),
            primaryAction: UIAction { _ in
                self.timer?.invalidate()
            }
        )
        button.setTitle("Stop", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProgressBar()
        configureProgressForwardButton()
        configureProgressBackwardButton()
        configureStopButton()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            print(self.downloadProgress)
        }
    }
}

private extension ViewController {
    
    private func configureProgressBar() {
        view.addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressBar.widthAnchor.constraint(equalToConstant: barWidth),
            progressBar.heightAnchor.constraint(equalToConstant: barHeight),
            progressBar.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            progressBar.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    private func configureProgressForwardButton() {
        view.addSubview(progressForwardButton)
        progressForwardButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressForwardButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -100),
            progressForwardButton.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 50)
        ])
    }
    
    private func configureProgressBackwardButton() {
        view.addSubview(progressBackwardButton)
        progressBackwardButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressBackwardButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 100),
            progressBackwardButton.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 50)
        ])
    }
    
    private func configureStopButton() {
        view.addSubview(stopButton)
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stopButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 50)
        ])
    }
    
    private func increaseProgress() {
        timer?.invalidate()
        timer = .scheduledTimer(
            withTimeInterval: timeInterval,
            repeats: true,
            block: { [self] _ in
                downloadProgress += progressInterval
                progressBar.setProgress(Float(downloadProgress) / Float(max), animated: true)
                if downloadProgress >= max {
                    timer?.invalidate()
                    downloadProgress = max
                    progressBar.setProgress(Float(max), animated: true)
                }
            }
        )
    }
    
    private func decreaseProgress() {
        timer?.invalidate()
        timer = .scheduledTimer(
            withTimeInterval: timeInterval,
            repeats: true,
            block: { [self] _ in
                downloadProgress -= progressInterval
                progressBar.setProgress(Float(downloadProgress) / Float(max), animated: true)
                if downloadProgress <= min {
                    timer?.invalidate()
                    downloadProgress = min
                    progressBar.setProgress(Float(min), animated: true)
                }
            }
        )
    }
}
