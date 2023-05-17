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
    let workoutView = WorkoutView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        workoutView.startWorkout()
    }

    private func setupUI() {
        self.view.backgroundColor = UIColor(named: "Black")

        self.view.addSubview(workoutView)
        workoutView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            workoutView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            workoutView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }

}


class BottomNavigationViewController: UIViewController {
    private let tabBar = UITabBar()
    private let homeTabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
    private let searchTabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
    private let settingsTabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addConstraints()
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(named: "Black")
        
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.tintColor = .systemBlue
        tabBar.delegate = self
        
        tabBar.items = [homeTabBarItem, searchTabBarItem, settingsTabBarItem]
        
        view.addSubview(tabBar)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension BottomNavigationViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // Handle tab bar item selection here
        switch item.tag {
        case 0:
            // Home tab selected
            // Perform necessary actions
            break
        case 1:
            // Search tab selected
            // Perform necessary actions
            break
        case 2:
            // Settings tab selected
            // Perform necessary actions
            break
        default:
            break
        }
    }
    

}
