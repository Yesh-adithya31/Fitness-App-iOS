//
//  CustomTextField.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-14.
//

import UIKit

class CustomTextField: UITextField {
    enum CustomTextFieldType {
            case username
            case email
            case password
        }
        
        private let authFieldType: CustomTextFieldType
        
        init(fieldType: CustomTextFieldType) {
            self.authFieldType = fieldType
            super.init(frame: .zero)
            
            self.backgroundColor = UIColor(named: "Black")
            self.textColor = UIColor(named: "White")
            self.layer.cornerRadius = 10
            self.layer.borderWidth = 1.0
            self.layer.borderColor = UIColor.white.cgColor
            
            self.returnKeyType = .done
            self.autocorrectionType = .no
            self.autocapitalizationType = .none
            
            self.leftViewMode = .always
            self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
            
            switch fieldType {
            case .username:
                self.attributedPlaceholder = NSAttributedString(
                    string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Green") as Any]
                )
            case .email:
                self.attributedPlaceholder = NSAttributedString(
                    string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Green") as Any]
                )
                self.keyboardType = .emailAddress
                self.textContentType = .emailAddress
                
            case .password:
                self.attributedPlaceholder = NSAttributedString(
                    string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Green") as Any]
                )

                self.textContentType = .oneTimeCode
                self.isSecureTextEntry = true

            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
