//
//  RegisterController.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-13.
//

import UIKit

class RegisterController: UIViewController {
    private var loadingView: LoadingView!
    private let headerView = AuthheaderView(title: "Register", subTitle: "Create your account")
    private let usernameField = CustomTextField(fieldType: .username)
    private let emailField = CustomTextField(fieldType: .email )
    private let passwordField = CustomTextField(fieldType: .password)

    private let signUpButton = CustomButton(title: "Sign Up", hasBackground: true, fontSize: .big)
    private let signInButton = CustomButton(title: "Already have an account? Sign in.", fontSize: .med)
    
    private let termsTextView : UITextView = {
        let attributeString = NSMutableAttributedString(string: "By creating an account, you agree to our Terms & Conditions and you acknowledge that you have read our Privacy Policy.")
        attributeString.addAttribute(.link, value: "https://policies.google.com/privacy?hl=en-US" , range: (attributeString.string as NSString).range(of: "Terms & Conditions"))
        
        attributeString.addAttribute(.link, value: "https://policies.google.com/terms?hl=en-US" , range: (attributeString.string as NSString).range(of: "Privacy Policy"))
        
        let tv = UITextView()
        tv.linkTextAttributes = [.foregroundColor: UIColor(named: "Green") as Any]
        tv.backgroundColor = .clear
        tv.attributedText = attributeString
        tv.textColor = .white
        tv.isSelectable = true
        tv.isEditable = false
        tv.delaysContentTouches = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI() {
        self.view.backgroundColor = UIColor(named: "Black")
        self.view.addSubview(headerView)
        self.view.addSubview(usernameField)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signUpButton)
        self.view.addSubview(termsTextView)
        self.view.addSubview(signInButton)
        
        // Create the loading view
        loadingView = LoadingView(frame: view.bounds)
        loadingView.isHidden = true
        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // Add the loading view as a subview
        view.addSubview(loadingView)
        
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.usernameField.translatesAutoresizingMaskIntoConstraints = false
        self.emailField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordField.translatesAutoresizingMaskIntoConstraints = false
        self.signInButton.translatesAutoresizingMaskIntoConstraints = false
        self.termsTextView.translatesAutoresizingMaskIntoConstraints = false
        self.signUpButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 222),
            
            self.emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            self.emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.usernameField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 12),
            self.usernameField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.usernameField.heightAnchor.constraint(equalToConstant: 55),
            self.usernameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
                        
            self.passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 12),
            self.passwordField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 12),
            self.signUpButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 55),
            self.signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.termsTextView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 6),
            self.termsTextView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.termsTextView.heightAnchor.constraint(equalToConstant: 44),
            self.termsTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.signInButton.topAnchor.constraint(equalTo: termsTextView.bottomAnchor, constant: 11),
            self.signInButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.signInButton.heightAnchor.constraint(equalToConstant: 44),
            self.signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
        ])
    }
    
    @objc private func didTapSignUp() {
        loadingView.isHidden = false
        let registerUserRequest = User(
            username: self.usernameField.text ?? "",
            email: self.emailField.text ?? "",
            password: self.passwordField.text ?? "")
        
        if !Validator.isValidEmail(for: registerUserRequest.email){
            AlertManager.showInvalidEmailAlert(on: self)
            loadingView.isHidden = true
            return
        }
        
        if !Validator.isValidUsername(for: registerUserRequest.username){
            AlertManager.showInvalidUsernameAlert(on: self)
            loadingView.isHidden = true
            return
        }
        
        if !Validator.isValidPassword(for: registerUserRequest.password){
            AlertManager.showInvalidPasswordAlert(on: self)
            loadingView.isHidden = true
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
                
                guard let self = self else { return }
                
                if let error = error {
                    AlertManager.showRegistrationErrorAlert(on: self, with: error)
                    loadingView.isHidden = true
                    return
                }
                
                if wasRegistered{
                    if let sceneDeletgate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                        sceneDeletgate.checkAuthentication()
                    }
                }else {
                    AlertManager.showRegistrationErrorAlert(on: self)
                    loadingView.isHidden = true
                }
            }
        }
    }
    
    @objc private func didTapSignIn() {
        let vc = LoginController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
}

//extension RegisterController: UITextViewDelegate {
//
//    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction ) -> Bool {
//
//        if URL.scheme == "terms" {
//            print("Terms")
//            self.showWebViwerController(with: "https://policies.google.com/privacy?hl=en-US")
//        } else if URL.scheme == "privacy" {
//            self.showWebViwerController(with: "https://policies.google.com/terms?hl=en-US")
//        }
//
//        return true
//    }
//
//    private func showWebViwerController(with urlString: String){
//        let webViewer = WebViewerController(with: urlString)
//        let nav = UINavigationController(rootViewController: webViewer)
//        self.present(nav, animated: true, completion: nil )
//    }
//
//    func textViewDidChangeSelection(_ textView: UITextView) {
//        textView.delegate = nil
//        textView.selectedTextRange = nil
//        textView.delegate = self
//    }
//}
