//
//  CustomTabBarController.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-17.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupViewControllers()
        
        delegate = self
    }
    
    private func setupTabBar() {
        tabBar.tintColor = UIColor(named: "Green")
        tabBar.barTintColor = UIColor(named: "White")
        tabBar.isTranslucent = false
    }
    
    private func setupViewControllers() {
        view.backgroundColor = UIColor(named: "LightBlack")
        let firstViewController = HomeController()
        let firstNavigationController = UINavigationController(rootViewController: firstViewController)
        firstNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Home"), tag: 0)
    
        
        let secondViewController = WorkoutViewController()
        let secondNavigationController = UINavigationController(rootViewController: secondViewController)
        secondNavigationController.tabBarItem = UITabBarItem(title: "Scedule", image: UIImage(named: "Insight"), tag: 1)
        
        let thirdViewController = GenderSelectionViewController()
        let thirdNavigationController = UINavigationController(rootViewController: thirdViewController)
        thirdNavigationController.tabBarItem = UITabBarItem(title: "Notification", image: UIImage(named: "Notification"), tag: 2)
        
        viewControllers = [firstNavigationController, secondNavigationController, thirdNavigationController]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            // Perform actions based on the selected index
            switch selectedIndex {
            case 0:
                // Handle selection of the first view controller (Home)
                // Show or perform actions for the Home view controller
                print("Selected Home")
            case 1:
                // Handle selection of the second view controller (Profile)
                // Show or perform actions for the Profile view controller
                print("Selected Profile")
            case 2:
                // Handle selection of the second view controller (Profile)
                // Show or perform actions for the Profile view controller
                print("Selected Scedule")
            default:
                break
            }
        }
    }
}


