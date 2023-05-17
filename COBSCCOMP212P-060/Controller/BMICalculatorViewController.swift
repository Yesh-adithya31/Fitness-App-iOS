//
//  BMICalculatorViewController.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-17.
//

import UIKit

class BMICalculatorViewController: UIViewController {
    private let weightTextField = UITextField()
    private let heightTextField = UITextField()
    private let calculateButton = UIButton(type: .system)
    private let resultLabel = UILabel()
    private let fitnessPlanLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        addConstraints()
    }

    private func configureUI() {
        view.backgroundColor = .white

        weightTextField.placeholder = "Weight (kg)"
        weightTextField.borderStyle = .roundedRect
        weightTextField.keyboardType = .decimalPad

        heightTextField.placeholder = "Height (cm)"
        heightTextField.borderStyle = .roundedRect
        heightTextField.keyboardType = .decimalPad

        calculateButton.setTitle("Calculate", for: .normal)
        calculateButton.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)

        resultLabel.textAlignment = .center
        fitnessPlanLabel.textAlignment = .center

        [weightTextField, heightTextField, calculateButton, resultLabel, fitnessPlanLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            weightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weightTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            weightTextField.widthAnchor.constraint(equalToConstant: 200),
            
            heightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heightTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 20),
            heightTextField.widthAnchor.constraint(equalToConstant: 200),
            
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculateButton.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 40),
            
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 40),
            
            fitnessPlanLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fitnessPlanLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fitnessPlanLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fitnessPlanLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20)
        ])
    }

    @objc private func calculateButtonTapped() {
        guard let weightText = weightTextField.text, let weight = Double(weightText),
              let heightText = heightTextField.text, let height = Double(heightText) else {
            resultLabel.text = "Invalid input"
            return
        }

        let heightInMeter = height / 100.0
        let bmi = weight / (heightInMeter * heightInMeter)
        resultLabel.text = "BMI: \(String(format: "%.2f", bmi))"

        let fitnessPlan = suggestFitnessPlan(bmi: bmi)
        fitnessPlanLabel.text = fitnessPlan
    }

    private func suggestFitnessPlan(bmi: Double) -> String {
        switch bmi {
        case ..<18.5:
            return "Underweight: Consider gaining some weight through a balanced diet and strength training."
        case 18.5..<25.0:
            return "Normal weight: Maintain a healthy lifestyle with regular exercise and a balanced diet."
        case 25.0..<30.0:
            return "Overweight: Focus on weight loss through portion control, regular exercise, and a balanced diet."
        default:
            return "Obese: Consult a healthcare professional for a personalized fitness and nutrition plan."
        }
    }
}

import AVKit
import AVFoundation

class MultipleVideoPlayerViewController: UIViewController {
    private var videoPlayerViews: [UIView] = []
    private var videoPlayers: [AVPlayer] = []
    private let videoURLs = ["http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"]

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        addConstraints()
        playVideos()
    }

    private func configureUI() {
        view.backgroundColor = .white

        for _ in videoURLs {
            let videoPlayerView = UIView()
            videoPlayerView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(videoPlayerView)
            videoPlayerViews.append(videoPlayerView)
        }
    }

    private func addConstraints() {
        for (index, videoPlayerView) in videoPlayerViews.enumerated() {
            NSLayoutConstraint.activate([
                videoPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                videoPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                videoPlayerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0 / CGFloat(videoPlayerViews.count)),
                videoPlayerView.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(index) * view.frame.height / CGFloat(videoPlayerViews.count))
            ])
        }
    }

    private func playVideos() {
        for (index, videoURL) in videoURLs.enumerated() {
            let videoPlayer = AVPlayer(url: URL(string: videoURL)!)
            let playerLayer = AVPlayerLayer(player: videoPlayer)
            playerLayer.frame = videoPlayerViews[index].bounds
            videoPlayerViews[index].layer.addSublayer(playerLayer)
            videoPlayer.play()
            videoPlayers.append(videoPlayer)
        }
    }
}

//class MultiplePlayerViewController: UIViewController {
//    private var playerControllers: [AVPlayerViewController] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        configurePlayerControllers()
//        addPlayerControllers()
//        addPlayerConstraints()
//    }
//    
//    private func configurePlayerControllers() {
//        let videoURLs = [
//            // Add your video URLs here
//            // Example: URL(string: "https://example.com/video1.mp4")!
//            URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!,  URL(string:"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!,  URL(string:"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!
//        ]
//        
//        for videoURL in videoURLs {
//            let player = AVPlayer(url: videoURL)
//            let playerController = AVPlayerViewController()
//            playerController.player = player
//            playerControllers.append(playerController)
//        }
//    }
//    
//    private func addPlayerControllers() {
//        for playerController in playerControllers {
//            addChild(playerController)
//            playerController.view.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(playerController.view)
//            playerController.didMove(toParent: self)
//        }
//    }
//    
//    private func addPlayerConstraints() {
//        for (index, playerController) in playerControllers.enumerated() {
//            let leadingConstraint = playerController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
//            let trailingConstraint = playerController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//            
//            let topConstraint: NSLayoutConstraint
//            let bottomConstraint: NSLayoutConstraint
//            
//            if index == 0 {
//                topConstraint = playerController.view.topAnchor.constraint(equalTo: view.topAnchor)
//            } else {
//                let previousPlayerController = playerControllers[index - 1]
//                topConstraint = playerController.view.topAnchor.constraint(equalTo: previousPlayerController.view.bottomAnchor)
//            }
//            
//            if index == playerControllers.count - 1 {
//                bottomConstraint = playerController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//            } else {
//                bottomConstraint = playerController.view.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
//            }
//            
//            NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
//        }
//    }
//}
