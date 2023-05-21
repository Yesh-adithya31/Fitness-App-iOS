//
//  SelectHeightViewController.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-17.
//

import UIKit

class SelectHeightViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    private var height = ""
    private var pickerView: UIPickerView!
    private let nextButton = CustomButton(title: "Next ▶", hasBackground: true, fontSize: .big)
    private let headingTextView = CustomTextView(title: "What’s your height?", fontSize: .big)
    private let subheadingTextView = CustomTextView(title: "This helps us create your personalized plan", fontSize: .small)
    private var options: [String] = ["148 cm", "149 cm", "150 cm","151 cm", "152 cm", "153 cm","154 cm", "155 cm", "156 cm","157 cm", "158 cm", "159 cm","160 cm", "161 cm", "162 cm","163 cm", "164 cm", "165 cm","166 cm", "167 cm", "168 cm", "169 cm", "170 cm", "171 cm", "172 cm", "173 cm", "174 cm","175 cm", "176 cm", "177 cm", "178 cm", "179 cm", "180 cm"]

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
        AuthService.shared.updateUser(valTitle: "height", value: self.height) { [weak self] wasHeight,error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showFetchingUserError(on: self, with: error)
                return
            }
            if wasHeight{
                let vc = SelectWeightViewController()
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
        height = "\(selectedOption)"
    }

//        func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//            let title = options[row]
//            let attributes: [NSAttributedString.Key: Any] = [
//                .foregroundColor: UIColor.white, // Customize the text color here
//                .font: UIFont.systemFont(ofSize: 30, weight: .bold)
//            ]
//
//            return NSAttributedString(string: title, attributes: attributes)
//        }
func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    let label = UILabel()
    label.textAlignment = .center
    label.textColor = UIColor(named: "Green")
    label.font = UIFont.systemFont(ofSize: 30) // Adjust the font size as desired
    let selectedOption = options[row]
    label.text = selectedOption// Provide the text for the row
    
    return label
}

}
