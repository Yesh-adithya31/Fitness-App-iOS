//
//  OnboardingViewController.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-14.
//

import UIKit

class OnboardingViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    private var pageViewController: UIPageViewController!
    private var pageControl: UIPageControl!
    
    private let onboardingViewControllers: [UIViewController] = {
        let firstVC = OnBoardFirstViewController()
        let secondVC = OnBoardSecondViewController()
        let thirdVC = OnBoardThirdViewController()


        return [firstVC, secondVC, thirdVC]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
        configurePageControl()
    }
    
    private func configurePageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.setViewControllers([onboardingViewControllers.first!], direction: .forward, animated: true, completion: nil)
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        // Set the constraints for the page view controller's view
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configurePageControl() {
        pageControl = UIPageControl()
        pageControl.numberOfPages = onboardingViewControllers.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor(named: "White")
        pageControl.currentPageIndicatorTintColor = UIColor(named: "Green")
        
        view.addSubview(pageControl)
        
        // Set the constraints for the page control
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20.0)
        ])
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = onboardingViewControllers.firstIndex(of: viewController), currentIndex > 0 else {
            return nil
        }
        return onboardingViewControllers[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = onboardingViewControllers.firstIndex(of: viewController), currentIndex < onboardingViewControllers.count - 1 else {
            return nil
        }
        return onboardingViewControllers[currentIndex + 1]
    }
    
    // MARK: - UIPageViewControllerDelegate
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let currentViewController = pageViewController.viewControllers?.first {
            if let currentIndex = onboardingViewControllers.firstIndex(of: currentViewController) {
                pageControl.currentPage = currentIndex
            }
        }
    }
}

// MARK: DROPDWON




// MARK: CUSTOM Schedule : Add , View, Delete and Update
class ScheduleViewController: UIViewController {
    private var tableView: UITableView!
    private var workoutSessions: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.backgroundColor = UIColor(named: "Black")
        // Set up the table view
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        // Set up the navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWorkoutSession))
        navigationItem.title = "Create Schedule"
    }
    
    @objc func addWorkoutSession() {
        let alertController = UIAlertController(title: "Add Workout Session", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Workout session name"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Enter time(ex: 3:00 AM)"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            var val1 = ""
            var val2 = ""
            if let sessionName = alertController.textFields?.first?.text, !sessionName.isEmpty {
                val1 = sessionName
            }
            if let sessionTime = alertController.textFields?.last?.text, !sessionTime.isEmpty {
                if Validator.isTimeValid(for: sessionTime){
                    val2 = sessionTime
                    self?.workoutSessions.append(val2+" - "+val1)
                    self?.tableView.reloadData()
                }
                
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutSessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = workoutSessions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Edit Workout Session", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Workout session name"
            textField.text = self.workoutSessions[indexPath.row]
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            if let sessionName = alertController.textFields?.first?.text, !sessionName.isEmpty {
                self?.workoutSessions[indexPath.row] = sessionName
                self?.tableView.reloadData()
            }
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.workoutSessions.remove(at: indexPath.row)
            self?.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
