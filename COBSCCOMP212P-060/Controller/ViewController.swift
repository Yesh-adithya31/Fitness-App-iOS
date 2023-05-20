//
//  ViewController.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-17.
//

import UIKit

//class ViewController: UIViewController {
//    let exerciseView = ExerciseView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        exerciseView.startTimer()
//        exerciseView.incrementRepCount()
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//    private func setupUI() {
//        self.view.backgroundColor = UIColor(named: "Black")
//
//        self.view.addSubview(exerciseView)
//        exerciseView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            exerciseView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            exerciseView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//        ])
//    }
//
//}

//class ViewController: UIViewController {
//    let counterView = CounterView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        counterView.start()
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//    private func setupUI() {
//        self.view.backgroundColor = UIColor(named: "Black")
//
//        self.view.addSubview(counterView)
//        counterView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            counterView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            counterView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//        ])
//    }
//
//}


class ViewController: UIViewController {
    let workoutView = ProfileHeader()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        workoutView.startWorkout()
    }

    private func setupUI() {
        self.view.backgroundColor = UIColor(named: "Black")

        self.view.addSubview(workoutView)
        workoutView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            workoutView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            workoutView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            workoutView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            workoutView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }

}

