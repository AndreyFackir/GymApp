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
    
    private let setsUnderline: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .specialLine
        return line
    }()
    
    private let repsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reps"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        return label
    }()
    
     let valueOfRepssLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "20"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        return label
    }()
    
    private var repsStackView = UIStackView()
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
        addSubview(setsUnderline)
        repsStackView = UIStackView(arrangeSubviews: [repsLabel, valueOfRepssLabel], axis: .horizontal, spacing: 10)
        addSubview(repsStackView)
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
        
        NSLayoutConstraint.activate([
            setsUnderline.topAnchor.constraint(equalTo: setStackView.bottomAnchor, constant: 5),
            setsUnderline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsUnderline.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            setsUnderline.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            repsStackView.topAnchor.constraint(equalTo: setsUnderline.bottomAnchor, constant: 10),
            repsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
