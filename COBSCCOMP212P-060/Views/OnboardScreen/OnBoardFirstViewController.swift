//
//  OnBoardFirstViewController.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-14.
//

import UIKit

class OnBoardFirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a UIImageView for the background image
        let backgroundImageView = UIImageView(image: UIImage(named: "splash_img1"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        
        // Set constraints to cover the entire screen
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
        
        // Ensure the background image is behind other views
        view.sendSubviewToBack(backgroundImageView)
    }
}

class OnBoardSecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a UIImageView for the background image
        let backgroundImageView = UIImageView(image: UIImage(named: "splash_img2"))
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        
        // Set constraints to cover the entire screen
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
        
        // Ensure the background image is behind other views
        view.sendSubviewToBack(backgroundImageView)
    }
}

class OnBoardThirdViewController: UIViewController {
    private let startButton = CustomButton(title: "Start Now >", hasBackground: true, fontSize: .big)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startButton.addTarget(self, action: #selector(didTapStart), for: .touchUpInside)
        
        // Create a UIImageView for the background image
        let backgroundImageView = UIImageView(image: UIImage(named: "splash_img3"))
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        view.addSubview(startButton)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints to cover the entire screen
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            
            self.startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0),
            self.startButton.heightAnchor.constraint(equalToConstant: 55),
            self.startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50),
        ])
        
        // Ensure the background image is behind other views
        view.sendSubviewToBack(backgroundImageView)
    }
    
    @objc private func didTapStart() {
        let vc = LoginController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
