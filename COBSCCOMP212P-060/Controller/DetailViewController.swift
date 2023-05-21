//
//  DetailViewController.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-20.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
    var selectedItemTitle: WorkoutMainList?
    let mainScrollView = UIScrollView()
    
    private let back = CustomButton(title: "◀ Back", hasBackground: false, fontSize: .small)
    private let subheadingWarmUpView = CustomTextView(title: "Wamp Up", fontSize: .med)
    private let subheadingWarkoutView = CustomTextView(title: "Workout", fontSize: .med)
    private let subheadingCoolDownView = CustomTextView(title: "Cool Down", fontSize: .med)
    
    private var wormupList = [WorkoutList]()
    private var workoutList = [WorkoutList]()
    private var cooldownList = [WorkoutList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Black")
        back.addTarget(self , action: #selector(backButtonTapped), for: .touchUpInside)
        
        if let data = selectedItemTitle {
            setupUI(for: data)
            
            AuthService.shared.fetchWorkouts(for: data.title) { [weak self] warmup, workout, cooldown, error in
                guard let self = self else { return }
                if let error = error {
                    AlertManager.showFetchingScheduleError(on: self, with: error)
                    return
                }
                if let warmup = warmup{
                    if let workout = workout{
                        if let cooldown = cooldown {
                            wormupList = warmup
                            workoutList = workout
                            cooldownList = cooldown
                            addWarmUpViews(wormupData: warmup, workoutData: workout, cooldown: cooldown)
                        }
                    }
                }
            }

        }
        
        
    }
    
    func setupUI(for workoutMain: WorkoutMainList){
        mainScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        mainScrollView.delegate = self
        mainScrollView.backgroundColor = UIColor(named: "Black")
        mainScrollView.bounces = false
        
        let headerView = DetailHeaderView(for: workoutMain)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        back.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(back)
        view.addSubview(headerView)
        view.addSubview(mainScrollView)
        // Set up constraints for the scroll view
        NSLayoutConstraint.activate([
            back.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            back.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            back.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            
            headerView.topAnchor.constraint(equalTo: back.bottomAnchor, constant: 5),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            headerView.heightAnchor.constraint(equalToConstant: 250),
            
            self.mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.mainScrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            self.mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func addWarmUpViews(wormupData: [WorkoutList], workoutData: [WorkoutList], cooldown: [WorkoutList]) {
        // Create and add workout card views to the scroll view
        // Adjust the values and layout as per your requirements
        
        let cardHeight: CGFloat = 60
        let cardSpacing: CGFloat = 10
        let numberOfCards = wormupData.count
        
        var previousCardView: SubWorkoutCardView?
        var previousWorkoutCardView: SubWorkoutCardView?
        var previousCoolDownCardView: SubWorkoutCardView?
        
        // MARK: WARM UP
        for i in 0..<numberOfCards {
            let warmupCardView = SubWorkoutCardView(title: wormupData[i].title, duration: "\(wormupData[i].duration)")
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewWormupItemTapped(_:)))
            warmupCardView.addGestureRecognizer(tapGesture)
            warmupCardView.tag = wormupData[i].ID
            
            warmupCardView.translatesAutoresizingMaskIntoConstraints = false
            subheadingWarmUpView.translatesAutoresizingMaskIntoConstraints = false
            subheadingWarkoutView.translatesAutoresizingMaskIntoConstraints = false
            subheadingCoolDownView.translatesAutoresizingMaskIntoConstraints = false
            mainScrollView.addSubview(subheadingWarkoutView)
            mainScrollView.addSubview(subheadingWarmUpView)
            mainScrollView.addSubview(subheadingCoolDownView)
            mainScrollView.addSubview(warmupCardView)
            
            // Set up constraints for the card view
            NSLayoutConstraint.activate([
                subheadingWarmUpView.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
                subheadingWarmUpView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
                subheadingWarmUpView.heightAnchor.constraint(equalToConstant: 40),
                
                warmupCardView.leadingAnchor.constraint(equalTo: subheadingWarmUpView.leadingAnchor),
                warmupCardView.trailingAnchor.constraint(equalTo: subheadingWarmUpView.trailingAnchor),
                warmupCardView.heightAnchor.constraint(equalToConstant: cardHeight),
                warmupCardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
                
            ])
            
            if let previousCardView = previousCardView {
                // Set up constraints for the vertical positioning of the card views
                NSLayoutConstraint.activate([
                    warmupCardView.topAnchor.constraint(equalTo: previousCardView.bottomAnchor, constant: cardSpacing)
                ])
            } else {
                // This is the first card view, set its top constraint to the scroll view's top anchor
                NSLayoutConstraint.activate([
                    warmupCardView.topAnchor.constraint(equalTo: subheadingWarmUpView.bottomAnchor, constant: 10)
                ])
            }
        
            
            previousCardView = warmupCardView
            
        }
        
        // Set the last card view's bottom constraint to the scroll view's bottom anchor
        if let lastCardView = previousCardView {
            NSLayoutConstraint.activate([
                subheadingWarkoutView.topAnchor.constraint(equalTo: lastCardView.bottomAnchor, constant: cardSpacing),
                subheadingWarkoutView.heightAnchor.constraint(equalToConstant: 40),
            ])
        }
        
        // MARK: WORK OUT
        for i in 0..<workoutData.count {
            let workoutCardView = SubWorkoutCardView(title: workoutData[i].title, duration: "\(workoutData[i].duration)")
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewWorkoutItemTapped(_:)))
            workoutCardView.addGestureRecognizer(tapGesture)
            workoutCardView.tag = workoutData[i].ID

            workoutCardView.translatesAutoresizingMaskIntoConstraints = false
            mainScrollView.addSubview(workoutCardView)

            // Set up constraints for the card view
            NSLayoutConstraint.activate([

                workoutCardView.leadingAnchor.constraint(equalTo: subheadingWarkoutView.leadingAnchor),
                workoutCardView.trailingAnchor.constraint(equalTo: subheadingWarkoutView.trailingAnchor),
                workoutCardView.heightAnchor.constraint(equalToConstant: cardHeight),
                workoutCardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),

            ])

            if let previousWorkoutCardView = previousWorkoutCardView {
                // Set up constraints for the vertical positioning of the card views
                NSLayoutConstraint.activate([
                    workoutCardView.topAnchor.constraint(equalTo: previousWorkoutCardView.bottomAnchor, constant: cardSpacing)
                ])
            } else {
                // This is the first card view, set its top constraint to the scroll view's top anchor
                NSLayoutConstraint.activate([
                    workoutCardView.topAnchor.constraint(equalTo: subheadingWarkoutView.bottomAnchor, constant: 10)
                ])
            }


            previousWorkoutCardView = workoutCardView

        }

        // Set the last card view's bottom constraint to the scroll view's bottom anchor
        if let lastWorkoutCardView = previousWorkoutCardView {
            NSLayoutConstraint.activate([
                subheadingCoolDownView.topAnchor.constraint(equalTo: lastWorkoutCardView.bottomAnchor, constant: cardSpacing),
                subheadingCoolDownView.heightAnchor.constraint(equalToConstant: 40),

            ])
        }
        
        // MARK: COOL DOWN
        for i in 0..<cooldown.count {
            let coolDownCardView = SubWorkoutCardView(title: cooldown[i].title, duration: "\(cooldown[i].duration)")
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewCooldownItemTapped(_:)))
            coolDownCardView.addGestureRecognizer(tapGesture)
            coolDownCardView.tag = cooldown[i].ID

            coolDownCardView.translatesAutoresizingMaskIntoConstraints = false
            mainScrollView.addSubview(coolDownCardView)

            // Set up constraints for the card view
            NSLayoutConstraint.activate([

                coolDownCardView.leadingAnchor.constraint(equalTo: subheadingCoolDownView.leadingAnchor),
                coolDownCardView.trailingAnchor.constraint(equalTo: subheadingCoolDownView.trailingAnchor),
                coolDownCardView.heightAnchor.constraint(equalToConstant: cardHeight),
                coolDownCardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),

            ])

            if let previousCoolDownCardView = previousCoolDownCardView {
                // Set up constraints for the vertical positioning of the card views
                NSLayoutConstraint.activate([
                    coolDownCardView.topAnchor.constraint(equalTo: previousCoolDownCardView.bottomAnchor, constant: cardSpacing)
                ])
            } else {
                // This is the first card view, set its top constraint to the scroll view's top anchor
                NSLayoutConstraint.activate([
                    coolDownCardView.topAnchor.constraint(equalTo: subheadingCoolDownView.bottomAnchor, constant: 10)
                ])
            }


            previousCoolDownCardView = coolDownCardView

        }

        // Set the last card view's bottom constraint to the scroll view's bottom anchor
        if let lastCoolDownCardView = previousCoolDownCardView {
            NSLayoutConstraint.activate([
                lastCoolDownCardView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: -cardSpacing),

            ])
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func backButtonTapped() {
        // Handle back button tap event
        navigationController?.popViewController(animated: true)
    }
    
    @objc func viewWormupItemTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let selectedView = gestureRecognizer.view,
              let selectedItem = wormupList.first(where: { $0.ID == selectedView.tag }) else {
            return
        }
        
        // Perform navigation to the detail page with modal values
        let vc = YouTubeViewController()
        vc.workoutData = selectedItem // Set your modal values

        // Present the detail view controller
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func viewWorkoutItemTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let selectedView = gestureRecognizer.view,
              let selectedItem = workoutList.first(where: { $0.ID == selectedView.tag }) else {
            return
        }
        
        // Perform navigation to the detail page with modal values
        let vc = YouTubeViewController()
        vc.workoutData = selectedItem // Set your modal values

        // Present the detail view controller
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func viewCooldownItemTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let selectedView = gestureRecognizer.view,
              let selectedItem = cooldownList.first(where: { $0.ID == selectedView.tag }) else {
            return
        }
        
        // Perform navigation to the detail page with modal values
        let vc = YouTubeViewController()
        vc.workoutData = selectedItem // Set your modal values

        // Present the detail view controller
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

