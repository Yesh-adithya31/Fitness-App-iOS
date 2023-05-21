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
    let workoutView = ProfileHeader()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        workoutView.startWorkout()
    }

    private func setupUI() {
        self.view.backgroundColor = UIColor(named: "Black")

        self.view.addSubview(workoutView)
        workoutView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            workoutView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            workoutView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            workoutView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            workoutView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }

}

import PassKit

class PaymentViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {
    private let resetPasswordButton = CustomButton(title: "Reset Password", hasBackground: true, fontSize: .big)
    // ... Your code ...
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.resetPasswordButton.addTarget(self, action: #selector(didTapForgetPassword ), for: .touchUpInside)
    }
    
    
    private func setupUI() {
        self.view.backgroundColor = UIColor(named: "Black")
        
        self.view.addSubview(resetPasswordButton)
        
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            self.resetPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.resetPasswordButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.resetPasswordButton.heightAnchor.constraint(equalToConstant: 55),
            self.resetPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
        ])
    }

    @objc private func didTapForgetPassword(){
        presentApplePayViewController()
    }
    
    func presentApplePayViewController() {
        // Create and configure the payment request
        let request = PKPaymentRequest()
        request.merchantIdentifier = "yourMerchantIdentifier"
        request.supportedNetworks = [.visa, .masterCard, .amex]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "US"
        request.currencyCode = "USD"
        
        let item = PKPaymentSummaryItem(label: "Gym Gymy Fitness Suscription", amount: NSDecimalNumber(decimal: 9.99))
        request.paymentSummaryItems = [item]
        
        // Create the payment authorization view controller
        let paymentController = PKPaymentAuthorizationViewController(paymentRequest: request)
        paymentController!.delegate = self
        
        // Present the payment authorization view controller
        if let paymentVC = paymentController {
            present(paymentVC, animated: true, completion: nil)
        }
    }
    
    // Implement the delegate method to handle payment authorization completion
    private func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        // Process the payment and handle the completion result
        // Call completion with the appropriate result based on payment success or failure
    }
    
    // Implement the delegate method to handle payment authorization dismissal
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        dismiss(animated: true, completion: nil)
    }

    // ... Your code ...
}
