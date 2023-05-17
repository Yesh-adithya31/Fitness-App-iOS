//
//  WorkoutCardView.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-17.
//

import UIKit

class WorkoutCardView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(title: String, desc: String, duration: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.descriptionLabel.text = desc
        self.durationLabel.text = duration
        self.setupUI()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//
//        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
//        setupUI()
    }
    
    private func setupUI() {
        // Add subviews
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(durationLabel)
        
        // Apply constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            durationLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            durationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            durationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            durationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
        // Set background color and corner radius
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}


class WorkoutsCardView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "Green")
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    init(workout: Workout) {
        super.init(frame: .zero)
        setupView()
        configure(with: workout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor(named: "LightBlack")
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        // Add constraints for image view
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        // Add constraints for title label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -40).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        
        // Add constraints for description label
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    }
    
    private func configure(with workout: Workout) {
        imageView.image = workout.image
        titleLabel.text = workout.title
        descriptionLabel.text = workout.description
    }
}
