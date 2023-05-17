//
//  WorkoutListViewController.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-17.
//

import UIKit

class WorkoutListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        view.backgroundColor = UIColor(named: "LightBlack")
        let workoutCardView = WorkoutCardView(title: " Gryffindor Strength ", desc: " Side Leg Raises ", duration: "30 sec(15 sec per side)")
        workoutCardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(workoutCardView)

        // Apply constraints to position the card view within the view controller's view
        NSLayoutConstraint.activate([
            workoutCardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            workoutCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            workoutCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            workoutCardView.heightAnchor.constraint(equalToConstant: 200)
        ])

    }

}


class WorkoutViewController: UIViewController, UIScrollViewDelegate {
    let scrollView = UIScrollView()
    var lastContentOffsetY: CGFloat = 0
    var timer: Timer?
    
    private let headingTextView = CustomTextView(title: "Hello Isini", fontSize: .big)
    private let subheadingTextView = CustomTextView(title: "Loading...", fontSize: .small)
    private let workoutTextView = CustomTextView(title: "Workout Plan", fontSize: .med)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        addWorkoutCardViews()
        startTimer()
        
    }
    
    private func setupScrollView() {
        view.backgroundColor = UIColor(named: "Black")
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor(named: "Black")
        scrollView.bounces = false

        headingTextView.translatesAutoresizingMaskIntoConstraints = false
        subheadingTextView.translatesAutoresizingMaskIntoConstraints = false
        workoutTextView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(headingTextView)
        view.addSubview(subheadingTextView)
        view.addSubview(workoutTextView)
        view.addSubview(scrollView)
        
        // Set up constraints for the scroll view
        NSLayoutConstraint.activate([
            self.headingTextView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headingTextView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.headingTextView.heightAnchor.constraint(equalToConstant: 40),
            
            self.subheadingTextView.topAnchor.constraint(equalTo: self.headingTextView.bottomAnchor),
            self.subheadingTextView.leadingAnchor.constraint(equalTo: headingTextView.leadingAnchor),
            self.subheadingTextView.heightAnchor.constraint(equalToConstant: 30),
            
            self.workoutTextView.topAnchor.constraint(equalTo: self.subheadingTextView.bottomAnchor, constant: 20),
            self.workoutTextView.leadingAnchor.constraint(equalTo: subheadingTextView.leadingAnchor),
            self.workoutTextView.heightAnchor.constraint(equalToConstant: 30),

            self.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: workoutTextView.bottomAnchor, constant: 20),
            self.scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func addWorkoutCardViews() {
        // Create and add workout card views to the scroll view
        // Adjust the values and layout as per your requirements
        
        let cardHeight: CGFloat = 210
        let cardSpacing: CGFloat = 16
        let numberOfCards = workouts.count
        
        var previousCardView: WorkoutsCardView?
        
        for i in 0..<numberOfCards {
            let cardView = WorkoutsCardView(workout: workouts[i])
            cardView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(cardView)
            
            // Set up constraints for the card view
            NSLayoutConstraint.activate([
                cardView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                cardView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                cardView.heightAnchor.constraint(equalToConstant: cardHeight),
                cardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
            ])
            
            if let previousCardView = previousCardView {
                // Set up constraints for the vertical positioning of the card views
                NSLayoutConstraint.activate([
                    cardView.topAnchor.constraint(equalTo: previousCardView.bottomAnchor, constant: cardSpacing)
                ])
            } else {
                // This is the first card view, set its top constraint to the scroll view's top anchor
                NSLayoutConstraint.activate([
                    cardView.topAnchor.constraint(equalTo: scrollView.topAnchor)
                ])
            }
            
            previousCardView = cardView
        }
        
        // Set the last card view's bottom constraint to the scroll view's bottom anchor
        if let lastCardView = previousCardView {
            NSLayoutConstraint.activate([
                lastCardView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -cardSpacing)
            ])
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateGreeting), userInfo: nil, repeats: true)
    }
    
    @objc func updateGreeting() {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: Date())

        var greeting: String
        if hour < 12 {
            greeting = "Good Morning,"
        } else if hour < 18 {
            greeting = "Good Afternoon,"
        } else {
            greeting = "Good Evening,"
        }

        // Update the UI with the greeting
        subheadingTextView.text = greeting
    }
}
