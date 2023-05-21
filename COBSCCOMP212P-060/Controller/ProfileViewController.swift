//
//  ProfileViewController.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-19.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileView = ProfileHeader()
    private let logout = CustomButton(title: "Logout", hasBackground: true, fontSize: .big)
    private let bmiBtn = CustomButton(title: "Calculate BMI ▶", hasBackground: false, fontSize: .big)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        logout.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        bmiBtn.addTarget(self, action: #selector(bmiPage), for: .touchUpInside)
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showFetchingUserError(on: self, with: error)
                return
            }
            
            if let user = user{
                self.profileView.assignValue(for: user)
            }
            
        }
    }

    private func setupUI() {
        self.view.backgroundColor = UIColor(named: "Black")

        self.view.addSubview(profileView)
        self.view.addSubview(bmiBtn)
        self.view.addSubview(logout)
        bmiBtn.translatesAutoresizingMaskIntoConstraints = false
        profileView.translatesAutoresizingMaskIntoConstraints = false
        logout.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            profileView.bottomAnchor.constraint(equalTo: self.bmiBtn.topAnchor, constant: 5),
            profileView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.bmiBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.bmiBtn.topAnchor.constraint(equalTo: self.profileView.bottomAnchor,constant: 10),
            self.bmiBtn.heightAnchor.constraint(equalToConstant: 55),
            self.bmiBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.logout.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.logout.topAnchor.constraint(equalTo: self.bmiBtn.bottomAnchor),
            self.logout.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            self.logout.heightAnchor.constraint(equalToConstant: 55),
            self.logout.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
        ])
    }
    
    @objc private func didTapLogout(){
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutErrorAlert(on: self, with: error)
                return
            }
            
            if let sceneDeletgate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDeletgate.checkAuthentication()
            }
        }
    }
    
    @objc private func bmiPage(){
        let vc = BMICalculatorViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }


}
