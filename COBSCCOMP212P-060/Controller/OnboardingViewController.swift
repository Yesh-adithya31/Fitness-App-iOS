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
