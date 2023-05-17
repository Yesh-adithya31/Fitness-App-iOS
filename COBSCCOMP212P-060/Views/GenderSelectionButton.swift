//
//  GenderSelectionButton.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-15.
//

import UIKit


class GenderSelectionButton: UIButton {
    override var isSelected: Bool {
        didSet {
            updateSelectionState()
        }
    }

    @objc private func buttonTapped() {
        isSelected.toggle()
    }

    private func updateSelectionState() {
        backgroundColor = isSelected ? UIColor(named: "Green") : UIColor(named: "LightBlack")
        
    }
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.frame = CGRect(x: 100, y: 100, width: 150, height: 150)
        self.layer.cornerRadius = frame.size.width / 2
        self.backgroundColor = UIColor(named: "LightBlack")
        self.setTitleColor(UIColor(named: "White"), for: .normal)
        self.setTitleColor(UIColor(named: "Black"), for: .selected)
        self.setImage(title == "Male" ? UIImage(named: "male_icon") : UIImage(named: "female_icon"), for: .normal)
        self.setImage(title == "Male" ? UIImage(named: "male_selected_icon") : UIImage(named: "female_selected_icon"), for: .selected)
        self.clipsToBounds = true
        self.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
