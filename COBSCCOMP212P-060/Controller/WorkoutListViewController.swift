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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        addWorkoutCardViews()
        
    }
    
    private func setupScrollView() {
        view.backgroundColor = UIColor(named: "Black")
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        scrollView.delegate = self

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Set up constraints for the scroll view
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func addWorkoutCardViews() {
        // Create and add workout card views to the scroll view
        // Adjust the values and layout as per your requirements
        
        let cardHeight: CGFloat = 200
        let cardSpacing: CGFloat = 16
        let numberOfCards = 10
        
        var previousCardView: WorkoutCardView?
        
        for _ in 0..<numberOfCards {
            let cardView = WorkoutCardView(title: " Gryffindor Strength ", desc: " Side Leg Raises ", duration: "30 sec(15 sec per side)")
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
}
