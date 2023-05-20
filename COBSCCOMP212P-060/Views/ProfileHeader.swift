//
//  ProfileHeader.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-19.
//

import UIKit

class ProfileHeader: UIView {
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(imageLiteralResourceName: "profile_image")
        iv.layer.cornerRadius = 45
        iv.clipsToBounds = true
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "White")
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.text = "Loading..."
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "White")
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Loading..."
        return label
    }()
 
 private let genderLabel: UILabel = {
     let label = UILabel()
     label.textColor = UIColor(named: "White")
     label.textAlignment = .center
     label.font = .systemFont(ofSize: 18, weight: .regular)
     label.text = "Gender"
     return label
 }()
 
 private let genderValueLabel: UILabel = {
     let label = UILabel()
     label.textColor = UIColor(named: "White")
     label.textAlignment = .center
     label.font = .systemFont(ofSize: 18, weight: .regular)
     label.text = "Loading..."
     return label
 }()
 
 private let dividergender : UIView = {
    let divide = UIView()
     divide.backgroundColor = UIColor(named: "Green")
     return divide
 }()
 
 private let ageLabel: UILabel = {
     let label = UILabel()
     label.textColor = UIColor(named: "White")
     label.textAlignment = .center
     label.font = .systemFont(ofSize: 18, weight: .regular)
     label.text = "Age"
     return label
 }()
 
 private let agevalueLabel: UILabel = {
     let label = UILabel()
     label.textColor = UIColor(named: "White")
     label.textAlignment = .center
     label.font = .systemFont(ofSize: 18, weight: .regular)
     label.text = "Loading..."
     return label
 }()
 
 private let dividerage : UIView = {
    let divide = UIView()
     divide.backgroundColor = UIColor(named: "Green")
     return divide
 }()
 
 private let heightLabel: UILabel = {
     let label = UILabel()
     label.textColor = UIColor(named: "White")
     label.textAlignment = .center
     label.font = .systemFont(ofSize: 18, weight: .regular)
     label.text = "Height"
     return label
 }()
 
 private let heightValueLabel: UILabel = {
     let label = UILabel()
     label.textColor = UIColor(named: "White")
     label.textAlignment = .center
     label.font = .systemFont(ofSize: 18, weight: .regular)
     label.text = "Loading"
     return label
 }()
 
 private let dividerheight : UIView = {
    let divide = UIView()
     divide.backgroundColor = UIColor(named: "Green")
     return divide
 }()
 
 private let weightLabel: UILabel = {
     let label = UILabel()
     label.textColor = UIColor(named: "White")
     label.textAlignment = .center
     label.font = .systemFont(ofSize: 18, weight: .regular)
     label.text = "Weight"
     return label
 }()
 
 private let weighthValueLabel: UILabel = {
     let label = UILabel()
     label.textColor = UIColor(named: "White")
     label.textAlignment = .center
     label.font = .systemFont(ofSize: 18, weight: .regular)
     label.text = "Loading..."
     return label
 }()
 
 private let dividerweight : UIView = {
    let divide = UIView()
     divide.backgroundColor = UIColor(named: "Green")
     return divide
 }()
 
 private let goalLabel: UILabel = {
     let label = UILabel()
     label.textColor = UIColor(named: "White")
     label.textAlignment = .center
     label.font = .systemFont(ofSize: 18, weight: .regular)
     label.text = "Goal"
     return label
 }()
 
 private let goalValueLabel: UILabel = {
     let label = UILabel()
     label.textColor = UIColor(named: "White")
     label.textAlignment = .center
     label.font = .systemFont(ofSize: 18, weight: .regular)
     label.text = "Loading..."
     return label
 }()
 
 
 private let dividergoal : UIView = {
    let divide = UIView()
     divide.backgroundColor = UIColor(named: "Green")
     return divide
 }()
 
 private let activityLevelLabel: UILabel = {
     let label = UILabel()
     label.textColor = UIColor(named: "White")
     label.textAlignment = .center
     label.font = .systemFont(ofSize: 18, weight: .regular)
     label.text = "Activity Level"
     return label
 }()
 private let activityLevelValueLabel: UILabel = {
     let label = UILabel()
     label.textColor = UIColor(named: "White")
     label.textAlignment = .center
     label.font = .systemFont(ofSize: 18, weight: .regular)
     label.text = "Loading..."
     return label
 }()
 
 private let divideractivity : UIView = {
    let divide = UIView()
     divide.backgroundColor = UIColor(named: "Green")
     return divide
 }()
 
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    func assignValue(for user: FetchUser){
        self.usernameLabel.text = user.username
        self.emailLabel.text = user.email
        self.genderValueLabel.text = user.gender
        self.agevalueLabel.text = user.age
        self.heightValueLabel.text = user.height
        self.weighthValueLabel.text = user.weight
        self.goalValueLabel.text = user.goal
        self.activityLevelValueLabel.text = user.activity_level
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        [logoImageView, usernameLabel, emailLabel, genderLabel, genderValueLabel, ageLabel, agevalueLabel, heightLabel, heightValueLabel, weightLabel, weighthValueLabel,goalLabel, goalValueLabel, activityLevelLabel, activityLevelValueLabel, dividergender,dividerage,dividerheight,dividerweight,dividergoal,divideractivity].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }


        NSLayoutConstraint.activate([
            self.logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 90),
            self.logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            
            self.usernameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 19),
            self.usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 12),
            self.emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.emailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.genderLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 12),
            self.genderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.genderLabel.trailingAnchor.constraint(equalTo: self.genderValueLabel.leadingAnchor, constant: -10),
            self.genderLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5 ),
            self.genderValueLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 12),
            self.genderValueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            self.dividergender.topAnchor.constraint(equalTo: self.genderLabel.bottomAnchor, constant: 10),
            self.dividergender.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.dividergender.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.dividergender.heightAnchor.constraint(equalToConstant: 1),
            
       
            self.ageLabel.topAnchor.constraint(equalTo: dividergender.bottomAnchor, constant: 12),
            self.ageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.ageLabel.trailingAnchor.constraint(equalTo: self.agevalueLabel.leadingAnchor, constant: -10),
            self.ageLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5 ),
            self.agevalueLabel.topAnchor.constraint(equalTo: dividergender.bottomAnchor, constant: 12),
            self.agevalueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),

            self.dividerage.topAnchor.constraint(equalTo: self.ageLabel.bottomAnchor, constant: 10),
            self.dividerage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.dividerage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.dividerage.heightAnchor.constraint(equalToConstant: 1),
            
            self.heightLabel.topAnchor.constraint(equalTo: dividerage.bottomAnchor, constant: 12),
            self.heightLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.heightLabel.trailingAnchor.constraint(equalTo: self.heightValueLabel.leadingAnchor, constant: 10),
            self.heightLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5 ),
            self.heightValueLabel.topAnchor.constraint(equalTo: dividerage.bottomAnchor, constant: 12),
            self.heightValueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            
            self.dividerheight.topAnchor.constraint(equalTo: self.heightLabel.bottomAnchor, constant: 10),
            self.dividerheight.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.dividerheight.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.dividerheight.heightAnchor.constraint(equalToConstant: 1),
            
            self.weightLabel.topAnchor.constraint(equalTo: dividerheight.bottomAnchor, constant: 12),
            self.weightLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.weightLabel.trailingAnchor.constraint(equalTo: self.weighthValueLabel.leadingAnchor, constant: -10),
            self.weightLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5 ),
            self.weighthValueLabel.topAnchor.constraint(equalTo: dividerheight.bottomAnchor, constant: 12),
            self.weighthValueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),

            self.dividerweight.topAnchor.constraint(equalTo: self.weightLabel.bottomAnchor, constant: 10),
            self.dividerweight.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.dividerweight.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.dividerweight.heightAnchor.constraint(equalToConstant: 1),

            self.goalLabel.topAnchor.constraint(equalTo: dividerweight.bottomAnchor, constant: 12),
            self.goalLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.goalLabel.trailingAnchor.constraint(equalTo: self.goalValueLabel.leadingAnchor, constant: -10),
            self.goalLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5 ),
            self.goalValueLabel.topAnchor.constraint(equalTo: dividerweight.bottomAnchor, constant: 12),
            self.goalValueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            self.dividergoal.topAnchor.constraint(equalTo: self.goalLabel.bottomAnchor, constant: 10),
            self.dividergoal.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.dividergoal.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.dividergoal.heightAnchor.constraint(equalToConstant: 1),
            
            self.activityLevelLabel.topAnchor.constraint(equalTo: dividergoal.bottomAnchor, constant: 12),
            self.activityLevelLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.activityLevelLabel.trailingAnchor.constraint(equalTo: self.activityLevelValueLabel.leadingAnchor, constant: -10),
            self.activityLevelLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5 ),
            self.activityLevelValueLabel.topAnchor.constraint(equalTo: dividergoal.bottomAnchor, constant: 12),
            self.activityLevelValueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),

            self.divideractivity.topAnchor.constraint(equalTo: self.activityLevelLabel.bottomAnchor, constant: 10),
            self.divideractivity.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.divideractivity.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.divideractivity.heightAnchor.constraint(equalToConstant: 1),
       
        ])
    }

}
