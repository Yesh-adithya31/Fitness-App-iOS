//
//  LoginController.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-13.
//

import UIKit

class LoginController: UIViewController {
    private var loadingView: LoadingView!
    private let headerView = AuthheaderView(title: "Login", subTitle: "Sign in to your account")
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)

    private let signInButton = CustomButton(title: "Sign In", hasBackground: true, fontSize: .big)
    private let newUserButton = CustomButton(title: "New User? Create Account.", fontSize: .med)
    private let forgotPasswordButton = CustomButton(title: "Forgot Password?", fontSize: .small)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        self.newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
        self.forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI() {
        self.view.backgroundColor = UIColor(named: "Black")
        self.view.addSubview(headerView)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signInButton)
        self.view.addSubview(newUserButton)
        self.view.addSubview(forgotPasswordButton)
        
        // Create the loading view
        loadingView = LoadingView(frame: view.bounds)
        loadingView.isHidden = true
        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // Add the loading view as a subview
        view.addSubview(loadingView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        newUserButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 222),
            
            self.emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            self.emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
                        
            self.passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22),
            self.passwordField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 22),
             self.signInButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
             self.signInButton.heightAnchor.constraint(equalToConstant: 55),
             self.signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
             
             self.newUserButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 11),
             self.newUserButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
             self.newUserButton.heightAnchor.constraint(equalToConstant: 44),
             self.newUserButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
             
             self.forgotPasswordButton.topAnchor.constraint(equalTo: newUserButton.bottomAnchor, constant: 6),
             self.forgotPasswordButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
             self.forgotPasswordButton.heightAnchor.constraint(equalToConstant: 44),
             self.forgotPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
        ])
    }
    
    @objc private func didTapSignIn() {
        loadingView.isHidden = false
        let loginRequest = LoginUserRequest(email: self.emailField.text ?? "", password: self.passwordField.text ?? "")
        
        if !Validator.isValidEmail(for: loginRequest.email){
            AlertManager.showInvalidEmailAlert(on: self)
            loadingView.isHidden = true
            return
        }
        
        if !Validator.isValidPassword(for: loginRequest.password){
            AlertManager.showInvalidPasswordAlert(on: self)
            loadingView.isHidden = true
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            AuthService.shared.signIn(with: loginRequest) { [weak self] error in
                
                guard let self = self else { return }
                 
                if let error = error {
                    AlertManager.showSignInErrorAlert(on: self, with: error)
                    loadingView.isHidden = true
                    return
                }
                
                if let sceneDeletgate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDeletgate.checkAuthentication()
                }
            }
        }

    }
    
    @objc private func didTapNewUser() {
        let vc = RegisterController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapForgotPassword() {
        let vc = ForgetPasswordController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
