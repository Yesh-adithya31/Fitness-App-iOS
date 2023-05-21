//
//  SelectAgeViewController.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-17.
//

import UIKit

class SelectAgeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
        private var age = ""
        private var pickerView: UIPickerView!
        private let nextButton = CustomButton(title: "Next ▶", hasBackground: true, fontSize: .big)
        private let headingTextView = CustomTextView(title: "How old are you ?", fontSize: .big)
        private let subheadingTextView = CustomTextView(title: "This helps us create your personalized plan", fontSize: .small)
        private var options: [String] = ["18", "19", "20","21", "22", "23","24", "25", "26","27", "28", "29","30", "31", "32","33", "34", "35","36", "37", "38", "39", "40", "41", "42", "43", "44","45", "46", "47", "48", "49", "50"]
    
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
            self.headingTextView.heightAnchor.constraint(equalToConstant: 50),
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
            AuthService.shared.updateUser(valTitle: "age", value: self.age) { [weak self] wasAge,error in
                guard let self = self else { return }
                if let error = error {
                    AlertManager.showFetchingUserError(on: self, with: error)
                    return
                }
                if wasAge{
                    let vc = SelectHeightViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
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
            age = "\(selectedOption)"
        }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        
        let rowView = UIView()
         
         // Add a label for the weight value
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = UIColor(named: "White")
            label.font = UIFont.systemFont(ofSize: 30) // Adjust the font size as desired
            let selectedOption = options[row]
            label.text = selectedOption// Provide the text for the row
         label.translatesAutoresizingMaskIntoConstraints = false
         rowView.addSubview(label)
         
         // Add a divider view
         let divider = UIView()
         divider.backgroundColor = UIColor(named: "Green")
         divider.translatesAutoresizingMaskIntoConstraints = false
         rowView.addSubview(divider)
         
         // Set constraints for the label and divider
         NSLayoutConstraint.activate([
             label.leadingAnchor.constraint(equalTo: rowView.leadingAnchor),
             label.trailingAnchor.constraint(equalTo: rowView.trailingAnchor),
             label.topAnchor.constraint(equalTo: rowView.topAnchor),
             label.bottomAnchor.constraint(equalTo: rowView.bottomAnchor),
             
//             divider.leadingAnchor.constraint(equalTo: rowView.leadingAnchor),
//             divider.trailingAnchor.constraint(equalTo: rowView.trailingAnchor),
             divider.centerXAnchor.constraint(equalTo: rowView.centerXAnchor),
             divider.bottomAnchor.constraint(equalTo: rowView.bottomAnchor),
             divider.heightAnchor.constraint(equalToConstant: 1),
             divider.widthAnchor.constraint(equalTo: rowView.widthAnchor, multiplier: 0.3)
         ])
         
         return rowView
    }

}

//class DropDownViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
//    private var pickerView: UIPickerView!
//    private var options: [String] = ["18", "19", "20","21", "22", "23","24", "25", "26","27", "28", "29","30", "31", "32","33", "34", "35","36", "37", "38", "39", "40", "41", "42", "43", "44","45", "46", "47", "48", "49", "50"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor(named: "Black")
//        // Create the picker view
//        pickerView = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 400))
//        pickerView.dataSource = self
//        pickerView.delegate = self
////        pickerView.tintColor = UIColor(named: "Green")
////        pickerView.backgroundColor = UIColor(named: "Green")
//        view.addSubview(pickerView)
//    }
//
//    // MARK: - UIPickerViewDataSource
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1 // Number of columns in the picker view
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return options.count // Number of rows in the picker view
//    }
//
//    // MARK: - UIPickerViewDelegate
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return options[row] // Title for each row in the picker view
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let selectedOption = options[row] // Handle the selected option
//        print("Selected option: \(selectedOption)")
//    }
//
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        let title = options[row]
//        let attributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.white, // Customize the text color here
//            .font: UIFont.systemFont(ofSize: 58)
//        ]
//
//        return NSAttributedString(string: title, attributes: attributes)
//    }
//}
