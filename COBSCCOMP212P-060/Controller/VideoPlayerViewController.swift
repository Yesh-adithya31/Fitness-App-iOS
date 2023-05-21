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


class YouTubeViewController: UIViewController, UIScrollViewDelegate {
    var workoutData: WorkoutList?
    private let playerController = AVPlayerViewController()
    private var isPlayPause = false
    private let back = CustomButton(title: "◀ Back", hasBackground: false, fontSize: .small)
    private let headingTextView = CustomTextView(title: "Loading...", fontSize: .big)
    private let timerView = TimerView()
    private let startButton = CustomButton(title: "Start Workout", hasBackground: true, fontSize: .big)
    
    private let durationTextView = CustomTextView(title: "⏱ Duration: ", fontSize: .med)
    private let bodyPartMainTextView = CustomTextView(title: "🏋 Bodt Parts", fontSize: .med)
    private let boadyPartTextView = CustomTextView(title: "Loading...", fontSize: .small)
    private let instructionMainTextView = CustomTextView(title: "📋 Instructions", fontSize: .med)
    private let instructionTextView = CustomTextView(title: "Loading...", fontSize: .small)
    private let muscleMainTextView = CustomTextView(title: "🤸 Muscles Involved", fontSize: .med)
    private let muscelTextView = CustomTextView(title: "Loading...", fontSize: .small)
    
    let mainScrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addConstraints()
        addScrollViewItems()
        setupPlayer(for: workoutData!.video_url)
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(named: "Black")
        
        mainScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        mainScrollView.delegate = self
        mainScrollView.backgroundColor = UIColor(named: "Black")
        mainScrollView.bounces = false
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        playerController.view.translatesAutoresizingMaskIntoConstraints = false
        playerController.view.backgroundColor = UIColor(named: "LightBlack")
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        back.translatesAutoresizingMaskIntoConstraints = false
        back.addTarget(self , action: #selector(backButtonTapped), for: .touchUpInside)
        
        headingTextView.text = workoutData?.title
        headingTextView.translatesAutoresizingMaskIntoConstraints = false
        
        timerView.assignVal(for: workoutData?.duration ?? 60)
        timerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(timerView)
        view.addSubview(headingTextView)
        view.addSubview(playerController.view)
        view.addSubview(startButton)
        view.addSubview(back)
        view.addSubview(mainScrollView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            back.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            back.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            back.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            
            playerController.view.topAnchor.constraint(equalTo: back.bottomAnchor),
            playerController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerController.view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/16),
            
            headingTextView.topAnchor.constraint(equalTo: playerController.view.bottomAnchor, constant: 10),
            headingTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            timerView.topAnchor.constraint(equalTo: headingTextView.bottomAnchor, constant: 10),
            timerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timerView.heightAnchor.constraint(equalToConstant: 40),
//            headingTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: timerView.bottomAnchor, constant: 8),
            startButton.heightAnchor.constraint(equalToConstant: 55),
            startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.mainScrollView.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 5),
            self.mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func addScrollViewItems(){
        
        durationTextView.text = "⏱ Duration: \(workoutData!.duration) sec"
        boadyPartTextView.text = workoutData?.body_part
        instructionTextView.text = workoutData?.instruction
        instructionTextView.textAlignment = .left
        muscelTextView.text = workoutData?.muscel
        
        durationTextView.translatesAutoresizingMaskIntoConstraints = false
        bodyPartMainTextView.translatesAutoresizingMaskIntoConstraints = false
        boadyPartTextView.translatesAutoresizingMaskIntoConstraints = false
        instructionMainTextView.translatesAutoresizingMaskIntoConstraints = false
        instructionTextView.translatesAutoresizingMaskIntoConstraints = false
        muscleMainTextView.translatesAutoresizingMaskIntoConstraints = false
        muscelTextView.translatesAutoresizingMaskIntoConstraints = false

        mainScrollView.addSubview(durationTextView)
        mainScrollView.addSubview(bodyPartMainTextView)
        mainScrollView.addSubview(boadyPartTextView)
        mainScrollView.addSubview(instructionMainTextView)
        mainScrollView.addSubview(instructionTextView)
        mainScrollView.addSubview(muscleMainTextView)
        mainScrollView.addSubview(muscelTextView)
        
        NSLayoutConstraint.activate([
            durationTextView.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
            durationTextView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
//            durationTextView.heightAnchor.constraint(equalToConstant: 40),
            
            bodyPartMainTextView.topAnchor.constraint(equalTo: durationTextView.bottomAnchor, constant: 20),
            bodyPartMainTextView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 10),
            
            boadyPartTextView.topAnchor.constraint(equalTo: bodyPartMainTextView.bottomAnchor, constant: 5),
            boadyPartTextView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 10),
            
            instructionMainTextView.topAnchor.constraint(equalTo: boadyPartTextView.bottomAnchor, constant: 20),
            instructionMainTextView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 10),
            
            instructionTextView.topAnchor.constraint(equalTo: instructionMainTextView.bottomAnchor, constant: 5),
            instructionTextView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 10),
            instructionTextView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor, multiplier: 1),
            instructionTextView.heightAnchor.constraint(equalTo: instructionTextView.heightAnchor),
            
            muscleMainTextView.topAnchor.constraint(equalTo: instructionTextView.bottomAnchor, constant: 20),
            muscleMainTextView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 10),
            
            muscelTextView.topAnchor.constraint(equalTo: muscleMainTextView.bottomAnchor, constant: 5),
            muscelTextView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 10),
            muscelTextView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: -20)
            
        ])
    }
    
    private func setupPlayer(for url: String) {
        guard let videoURL = URL(string: url) else {
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
        startButton.setTitle(isPlayPause ? "Pause" : "Start Workout", for: .normal)
        !isPlayPause ? timerView.stopWorkout() :timerView.startWorkout()
    }
    
    @objc private func playerItemDidReachEnd() {
        playerController.player?.seek(to: .zero)
        playerController.player?.play()
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
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
