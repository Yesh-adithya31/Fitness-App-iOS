//
//  ExerciseView.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-17.
//

import UIKit

//class ExerciseView: UIView {
//    private var timer: Timer?
//    private var elapsedTime: TimeInterval = 0.0
//    private var repCount: Int = 0
//    
//    private let timerLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 24)
//        label.textColor = .black
//        label.textAlignment = .center
//        return label
//    }()
//    
//    private let repCountLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 18)
//        label.textColor = .black
//        label.textAlignment = .center
//        return label
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        configureUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        configureUI()
//    }
//    
//    private func configureUI() {
//        backgroundColor = UIColor(named: "White")
//        
//        addSubview(timerLabel)
//        addSubview(repCountLabel)
//        
//        timerLabel.translatesAutoresizingMaskIntoConstraints = false
//        timerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        timerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        
//        repCountLabel.translatesAutoresizingMaskIntoConstraints = false
//        repCountLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 16).isActive = true
//        repCountLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//    }
//    
//    func startTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
//    }
//    
//    func stopTimer() {
//        timer?.invalidate()
//        timer = nil
//    }
//    
//    func incrementRepCount() {
//        repCount += 1
//        repCountLabel.text = "Reps: \(repCount)"
//        repCountLabel.textColor = UIColor(named: "Green")
//    }
//    
//    @objc private func updateTimer() {
//        elapsedTime += 0.1
//        timerLabel.text = formatTime(elapsedTime)
//        timerLabel.textColor = UIColor(named: "Green")
//    }
//    
//    private func formatTime(_ time: TimeInterval) -> String {
//        let minutes = Int(time) / 60
//        let seconds = Int(time) % 60
//        let milliseconds = Int(time * 10) % 10
//        return String(format: "%02d:%02d:%01d", minutes, seconds, milliseconds)
//    }
//}


//class CounterView: UIView {
//    private var timer: Timer?
//    private var counterLabel: UILabel!
//    private var repsLabel: UILabel!
//    private var counter: Int = 0
//    private var reps: Int = 0
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        configureUI()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//
//        configureUI()
//    }
//
//    private func configureUI() {
//        counterLabel = UILabel()
//        counterLabel.translatesAutoresizingMaskIntoConstraints = false
//        counterLabel.font = UIFont.systemFont(ofSize: 24)
//        counterLabel.textAlignment = .center
//        counterLabel.text = "0"
//        counterLabel.textColor = UIColor(named: "Green")
//
//        repsLabel = UILabel()
//        repsLabel.translatesAutoresizingMaskIntoConstraints = false
//        repsLabel.font = UIFont.systemFont(ofSize: 18)
//        repsLabel.textAlignment = .center
//        repsLabel.text = "Reps: 0"
//        repsLabel.textColor = UIColor(named: "Green")
//
//        addSubview(counterLabel)
//        addSubview(repsLabel)
//
//        NSLayoutConstraint.activate([
//            counterLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            counterLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//
//            repsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            repsLabel.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 16)
//        ])
//    }
//
//    func start() {
//        stop()
//
//        counter = 0
//        reps = 0
//        updateCounterLabel()
//        updateRepsLabel()
//
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
//    }
//
//    func stop() {
//        timer?.invalidate()
//        timer = nil
//    }
//
//    @objc private func updateTimer() {
//        counter += 1
//        updateCounterLabel()
//
//        if counter >= 30 {
//            reps += 1
//            updateRepsLabel()
//            counter = 0
//        }
//    }
//
//    private func updateCounterLabel() {
//        counterLabel.text = "\(counter)"
//    }
//
//    private func updateRepsLabel() {
//        repsLabel.text = "Reps: \(reps)"
//    }
//}

class WorkoutView: UIView {
    private var timer: Timer?
    private var counter: Int = 0
    private var repsCount: Int = 0
    private let timerLabel = UILabel()
    private let repsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureUI()
        addConstraints()
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.font = UIFont.systemFont(ofSize: 40)
        timerLabel.textAlignment = .center
        timerLabel.textColor = UIColor(named: "Green")
        
        repsLabel.translatesAutoresizingMaskIntoConstraints = false
        repsLabel.font = UIFont.systemFont(ofSize: 20)
        repsLabel.textAlignment = .center
        repsLabel.textColor = UIColor(named: "Green")
        
        addSubview(timerLabel)
        addSubview(repsLabel)
    }
    
    private func addConstraints() {
        let constraints = [
            timerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            repsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            repsLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func startWorkout() {
        timer?.invalidate() // Invalidate any existing timer
        
        counter = 0
        repsCount = 0
        
        timerLabel.text = "0"
        repsLabel.text = "Reps: 0"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        counter += 1
        timerLabel.text = "\(counter)"
        
        if counter > 60 {
            stopWorkout()
        } else if counter % 4 == 0 {
            repsCount += 1
            repsLabel.text = "Reps: \(repsCount)"
            
            if repsCount >= 15 {
                stopWorkout()
            }
        }
    }
    
    private func stopWorkout() {
        timer?.invalidate()
        timer = nil
    }
}
