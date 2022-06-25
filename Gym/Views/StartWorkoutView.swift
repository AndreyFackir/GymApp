//
//  StartWorkoutView.swift
//  Gym
//
//  Created by Андрей Яфаркин on 25.06.2022.
//

import UIKit

class StartWorkoutView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.textColor = .specialBlack
        label.font = .robotoMedium24()
        return label
     }()
    
    private let setsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sets"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        return label
    }()
    
     let valueOfSetsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1/4"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        return label
    }()
    
    private var setStackView = UIStackView()
    
}

//MARK: - SetupViews
extension StartWorkoutView {
    private func setupView() {
        backgroundColor = .specialBrown
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        addSubview(nameLabel)
        setStackView = UIStackView(arrangeSubviews: [setsLabel, valueOfSetsLabel], axis: .horizontal, spacing: 10)
        addSubview(setStackView)
    }
}

//MARK: - Set Constraints
extension StartWorkoutView {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            setStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            setStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
