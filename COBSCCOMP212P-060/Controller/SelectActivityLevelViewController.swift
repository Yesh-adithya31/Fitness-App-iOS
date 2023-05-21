//
//  SelectActivityLevelViewController.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-19.
//

import UIKit

class SelectActivityLevelViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    private var activityLevel = ""
    private var pickerView: UIPickerView!
    private let nextButton = CustomButton(title: "Final Step", hasBackground: true, fontSize: .big)
    private let headingTextView = CustomTextView(title: "Your regular physical activity level?", fontSize: .big)
    private let subheadingTextView = CustomTextView(title: "This helps us create your personalized plan", fontSize: .small)
    private var options: [String] = ["Rookie", "Beginner", "Intermediate","Advance", "True Beast"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Black")
        setupUI()
        self.nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
    }

func setupUI(){
    pickerView = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 400))
    pickerView.dataSource = self
    pickerView.delegate = self
    
    headingTextView.translatesAutoresizingMaskIntoConstraints = false
    subheadingTextView.translatesAutoresizingMaskIntoConstraints = false
    nextButton.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(headingTextView)
    view.addSubview(subheadingTextView)
    view.addSubview(nextButton)
    view.addSubview(pickerView)
    
    NSLayoutConstraint.activate([
        self.headingTextView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
        self.headingTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        self.headingTextView.heightAnchor.constraint(equalTo: self.headingTextView.heightAnchor),
        self.headingTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
        
        self.subheadingTextView.topAnchor.constraint(equalTo: self.headingTextView.bottomAnchor, constant: 10),
        self.subheadingTextView.centerXAnchor.constraint(equalTo: self.headingTextView.centerXAnchor),
        self.subheadingTextView.heightAnchor.constraint(equalToConstant: 100),
        self.subheadingTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),


        self.nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        self.nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0),
        self.nextButton.heightAnchor.constraint(equalToConstant: 55),
        self.nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50),
    ])

}

@objc func didTapNext() {
    DispatchQueue.main.asyncAfter(deadline: .now()) {
        AuthService.shared.updateUser(valTitle: "activity_level", value: self.activityLevel) { [weak self] wasRegistered,error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showFetchingUserError(on: self, with: error)
                return
            }
            if wasRegistered{
                if let sceneDeletgate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDeletgate.checkAuthentication()
                }
            }else {
                AlertManager.showRegistrationErrorAlert(on: self)
            }
        }
    }
}

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Number of columns in the picker view
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count // Number of rows in the picker view
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row] // Title for each row in the picker view
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedOption = options[row] // Handle the selected option
        print("Selected option: \(selectedOption)")
        activityLevel = selectedOption
    }
    
func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    let label = UILabel()
    label.textAlignment = .center
    label.textColor = UIColor(named: "Green")
    label.font = UIFont.systemFont(ofSize: 26) // Adjust the font size as desired
    let selectedOption = options[row]
    label.text = selectedOption// Provide the text for the row
    
    return label
}

}
