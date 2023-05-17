//
//  CustomTextView.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-17.
//

import UIKit

class CustomTextView: UITextView {
    enum FontSize {
        case big
        case med
        case small
    }
    
    init(title: String, fontSize: FontSize) {
        super.init(frame: CGRect.zero, textContainer: nil)
        let attributeString = NSMutableAttributedString(string: title)
        backgroundColor = .clear
        attributedText = attributeString
        textColor = .white
        textAlignment = .center
        switch fontSize {
        case .big:
            font = .systemFont(ofSize: 32, weight: .bold)
            
        case .med:
            font = .systemFont(ofSize: 22, weight: .semibold)
            
        case .small:
            font = .systemFont(ofSize: 16, weight: .regular)
        }
        isSelectable = false
        isEditable = false
        delaysContentTouches = false
        isScrollEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
