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

//        AuthService.shared.fetchWorkouts(for: "Gryffindor Strength") { [weak self] list, error in
//            guard let self = self else { return }
//            if let error = error {
////                AlertManager.showFetchingUserError(on: self, with: error)
//                return
//            }
//            
//            if let list = list{
////                self.label.text = "\(user.username)\n\(user.email)"
//                print("Datils List: \(list)")
//            }
//        }
        
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
        let firstViewController = WorkoutViewController()
        let firstNavigationController = UINavigationController(rootViewController: firstViewController)
        firstNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Home"), tag: 0)
    
        
        let secondViewController = ScheduleViewController()
        let secondNavigationController = UINavigationController(rootViewController: secondViewController)
        secondNavigationController.tabBarItem = UITabBarItem(title: "Scedule", image: UIImage(named: "Insight"), tag: 1)
        
        let thirdViewController = ProfileViewController()
        let thirdNavigationController = UINavigationController(rootViewController: thirdViewController)
        thirdNavigationController.tabBarItem = UITabBarItem(title: "Notification", image: UIImage(named: "Notification"), tag: 2)
        
        viewControllers = [firstNavigationController, secondNavigationController, thirdNavigationController]
    }
    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        if let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
//            // Perform actions based on the selected index
//            switch selectedIndex {
//            case 0:
//                // Handle selection of the first view controller (Home)
//                // Show or perform actions for the Home view controller
//                print("Selected Home")
//            case 1:
//                // Handle selection of the second view controller (Profile)
//                // Show or perform actions for the Profile view controller
//                print("Selected Scedule")
//            case 2:
//                // Handle selection of the second view controller (Profile)
//                // Show or perform actions for the Profile view controller
//                print("Selected Profile")
//            default:
//                break
//            }
//        }
//    }
    
}


