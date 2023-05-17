//
//  VideoPlayerViewController.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-17.
//

import UIKit

class VideoPlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

import AVKit


class MultiplePlayerViewController: UIViewController {
    private var playerControllers: [AVPlayerViewController] = []
    private var currentVideoIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Black")
        configurePlayerControllers()
        addPlayerControllers()
        addPlayerConstraints()

        // Start playing the first video
        playCurrentVideo()
    }

    private func configurePlayerControllers() {
        let videoURLs = [
            URL(string: "https://firebasestorage.googleapis.com/v0/b/fitness-app-3d335.appspot.com/o/7b5446b9-a32f-4332-a430-b0d2ba4d3e7d.MP4?alt=media&token=fa0968dc-c3f6-4fda-be66-d7c013d6c750")!,
            URL(string:"https://firebasestorage.googleapis.com/v0/b/fitness-app-3d335.appspot.com/o/7b5446b9-a32f-4332-a430-b0d2ba4d3e7d.MP4")!,
            URL(string:"https://firebasestorage.googleapis.com/v0/b/fitness-app-3d335.appspot.com/o/7b5446b9-a32f-4332-a430-b0d2ba4d3e7d.MP4")!
        ]

        for videoURL in videoURLs {
            let player = AVPlayer(url: videoURL)
            let playerController = AVPlayerViewController()
            playerController.player = player
            playerControllers.append(playerController)
        }
    }

    private func addPlayerControllers() {
        for playerController in playerControllers {
            addChild(playerController)
            playerController.view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(playerController.view)
            playerController.didMove(toParent: self)
        }
    }

    private func addPlayerConstraints() {
        for (index, playerController) in playerControllers.enumerated() {
            let leadingConstraint = playerController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            let trailingConstraint = playerController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)

            let topConstraint: NSLayoutConstraint

            if index == 0 {
                topConstraint = playerController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            } else {
                let previousPlayerController = playerControllers[index - 1]
                topConstraint = playerController.view.topAnchor.constraint(equalTo: previousPlayerController.view.bottomAnchor, constant: 10)
            }

//            if index == playerControllers.count - 1 {
//                bottomConstraint = playerController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//            } else {
//                bottomConstraint = playerController.view.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
//            }

            NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint,
                playerController.view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/16)])
        }
    }

    private func playCurrentVideo() {
        guard currentVideoIndex >= 0, currentVideoIndex < playerControllers.count else {
            return
        }

        let currentPlayerController = playerControllers[currentVideoIndex]
        currentPlayerController.player?.play()
    }

    private func stopCurrentVideo() {
        guard currentVideoIndex >= 0, currentVideoIndex < playerControllers.count else {
            return
        }

        let currentPlayerController = playerControllers[currentVideoIndex]
        currentPlayerController.player?.pause()
    }

    private func moveToNextVideo() {
        stopCurrentVideo()

        currentVideoIndex += 1

        if currentVideoIndex >= playerControllers.count {
            currentVideoIndex = 0
        }

        playCurrentVideo()
    }

    // Example button action to move to the next video
    @objc private func nextButtonTapped() {
        moveToNextVideo()
    }
}


class YouTubeViewController: UIViewController {
    private let playerController = AVPlayerViewController()
    private let startButton = UIButton(type: .system)
    private var isPlayPause = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addConstraints()
        setupPlayer()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        playerController.view.translatesAutoresizingMaskIntoConstraints = false
        playerController.view.backgroundColor = .black
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitle(isPlayPause ? "Pause" : "Start", for: .normal)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        view.addSubview(playerController.view)
        view.addSubview(startButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            playerController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerController.view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/16),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: playerController.view.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupPlayer() {
        guard let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/fitness-app-3d335.appspot.com/o/7b5446b9-a32f-4332-a430-b0d2ba4d3e7d.MP4?alt=media&token=fa0968dc-c3f6-4fda-be66-d7c013d6c750") else {
            fatalError("Invalid video URL")
        }
        
        let player = AVPlayer(url: videoURL)
        playerController.player?.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: .AVPlayerItemDidPlayToEndTime, object: player)
                
        playerController.player = player
    }
    
    @objc private func startButtonTapped() {
        isPlayPause ? playerController.player?.pause() : playerController.player?.play()
        isPlayPause.toggle()
        startButton.setTitle(isPlayPause ? "Pause" : "Start", for: .normal)
//        startButton.isHidden = true
    }
    
    @objc private func playerItemDidReachEnd() {
        playerController.player?.seek(to: .zero)
        playerController.player?.play()
    }
}


//class YouTubeViewController: UIViewController {
//    private let playerController = AVPlayerViewController()
//    private let videoTitleLabel = UILabel()
//    private let videoDescriptionLabel = UILabel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        configureUI()
//        addConstraints()
//        loadVideo()
//    }
//
//    private func configureUI() {
//        view.backgroundColor = .white
//
//        playerController.view.translatesAutoresizingMaskIntoConstraints = false
//        playerController.view.backgroundColor = .black
//        playerController.showsPlaybackControls = true
//
//        videoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
//        videoTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
//        videoTitleLabel.numberOfLines = 0
//
//        videoDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        videoDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
//        videoDescriptionLabel.numberOfLines = 0
//
//        view.addSubview(playerController.view)
//        view.addSubview(videoTitleLabel)
//        view.addSubview(videoDescriptionLabel)
//    }
//
//    private func addConstraints() {
//        let constraints = [
//            playerController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            playerController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            playerController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            playerController.view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/16),
//
//            videoTitleLabel.topAnchor.constraint(equalTo: playerController.view.bottomAnchor, constant: 16),
//            videoTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            videoTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//
//            videoDescriptionLabel.topAnchor.constraint(equalTo: videoTitleLabel.bottomAnchor, constant: 8),
//            videoDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            videoDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            videoDescriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
//        ]
//
//        NSLayoutConstraint.activate(constraints)
//    }
//
//    private func loadVideo() {
//        guard let videoURL = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") else {
//            fatalError("Invalid video URL")
//        }
//
//        let player = AVPlayer(url: videoURL)
//        playerController.player = player
//        player.play()
//
//        videoTitleLabel.text = "Video Title"
//        videoDescriptionLabel.text = "Video Description"
//    }
//}
