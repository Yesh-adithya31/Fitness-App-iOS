//
//  AlertManager.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-14.
//

import UIKit

class AlertManager {
    private static func showAlertMessage(on vc: UIViewController, with title: String,and message: String?){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            vc.present(alert, animated: true)
        }
    }
}

// MARK: - User errors
extension AlertManager {
    public static func showInvalidEmailAlert(on vc: UIViewController){
        self.showAlertMessage(on: vc, with: "Invalid Email", and: "Please enter a valid email.")
    }
    
    public static func showInvalidPasswordAlert(on vc: UIViewController){
        self.showAlertMessage(on: vc, with: "Invalid Password", and: "Please enter a valid password.")
    }
    
    public static func showInvalidUsernameAlert(on vc: UIViewController){
        self.showAlertMessage(on: vc, with: "Invalid Username", and: "Please enter a valid username.")
    }
}

// MARK: - Sign UP errors
extension AlertManager {
    public static func showRegistrationErrorAlert(on vc: UIViewController){
        self.showAlertMessage(on: vc, with: "Unknown Registration Error", and: nil)
    }
    
    public static func showRegistrationErrorAlert(on vc: UIViewController, with error: Error){
        self.showAlertMessage(on: vc, with: "Unknown Registration Error", and: "\(error.localizedDescription)")
    }
    
}

// MARK: - Log In errors
extension AlertManager {
    public static func showSignInErrorAlert(on vc: UIViewController){
        self.showAlertMessage(on: vc, with: "Unknown Error Signing In", and: nil)
    }
    
    public static func showSignInErrorAlert(on vc: UIViewController, with error: Error){
        self.showAlertMessage(on: vc, with: "Error Signing In", and: "\(error.localizedDescription)")
    }
    
}

// MARK: - Log out errors
extension AlertManager {
    
    public static func showLogoutErrorAlert(on vc: UIViewController, with error: Error){
        self.showAlertMessage(on: vc, with: "Logout Error", and: "\(error.localizedDescription)")
    }
    
}


// MARK: - Forgot password errors
extension AlertManager {
    
    public static func showPasswordResetAlert(on vc: UIViewController){
        self.showAlertMessage(on: vc, with: "Password Reset Sent", and: "Password reset link sent your email")
    }
    
    public static func showErrorSendingPasswordResetAlert(on vc: UIViewController, with error: Error){
        self.showAlertMessage(on: vc, with: "Error Sending password Reset", and: "\(error.localizedDescription)")
    }
    
}


// MARK: - Fetching user errors
extension AlertManager {
    
    public static func showFetchingUserError(on vc: UIViewController, with error: Error){
        self.showAlertMessage(on: vc, with: "Error Fetching User", and: "\(error.localizedDescription)")
    }
    
    public static func showUnknownFetchingUserError(on vc: UIViewController, with error: Error){
        self.showAlertMessage(on: vc, with: "Unknown Error Fetching User", and: nil)
    }
}

// MARK: - Fetching user errors
extension AlertManager {
    
    public static func showFetchingWorkoutsError(on vc: UIViewController, with error: Error){
        self.showAlertMessage(on: vc, with: "Error Fetching Workouts List", and: "\(error.localizedDescription)")
    }
}

// MARK: - Fetching Schedule errors
extension AlertManager {
    
    public static func showCreatingScheduleError(on vc: UIViewController, with error: Error){
        self.showAlertMessage(on: vc, with: "Error Creating Schedule List", and: "\(error.localizedDescription)")
    }
    
    public static func showFetchingScheduleError(on vc: UIViewController, with error: Error){
        self.showAlertMessage(on: vc, with: "Error Fetching Schedule List", and: "\(error.localizedDescription)")
    }
    
    public static func showCreateScheduleSuccessAlert(on vc: UIViewController){
        self.showAlertMessage(on: vc, with: "Data saved successfully", and: "You entered data saved into database.")
    }
}
