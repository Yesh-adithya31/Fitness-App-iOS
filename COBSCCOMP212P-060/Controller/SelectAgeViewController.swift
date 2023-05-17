//
//  SelectAgeViewController.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-17.
//

import UIKit

class SelectAgeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
        private var pickerView: UIPickerView!
        private var options: [String] = ["18", "19", "20","21", "22", "23","24", "25", "26","27", "28", "29","30", "31", "32","33", "34", "35","36", "37", "38", "39", "40", "41", "42", "43", "44","45", "46", "47", "48", "49", "50"]
    
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = UIColor(named: "Black")
            // Create the picker view
            pickerView = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 400))
            pickerView.dataSource = self
            pickerView.delegate = self
    //        pickerView.tintColor = UIColor(named: "Green")
    //        pickerView.backgroundColor = UIColor(named: "Green")
            view.addSubview(pickerView)
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
        }
    
        func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
            let title = options[row]
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white, // Customize the text color here
                .font: UIFont.systemFont(ofSize: 58)
            ]
    
            return NSAttributedString(string: title, attributes: attributes)
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
