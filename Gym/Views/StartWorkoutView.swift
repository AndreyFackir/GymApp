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
    
    let valueOfRepsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "20"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        return label
    }()
    
    private var repsStackView = UIStackView()
    
    private let repsUnderline: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .specialLine
        return line
    }()
    
    private let editingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Editing", for: .normal)
        button.tintColor = .specilaLightBrown
        button.titleLabel?.font = .robotoMedium14()
        button.addTarget(self, action: #selector(editingButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func editingButtonTapped () {
        print("editingButtonTapped")
    }
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
        repsStackView = UIStackView(arrangeSubviews: [repsLabel, valueOfRepsLabel], axis: .horizontal, spacing: 10)
        addSubview(repsStackView)
        addSubview(repsUnderline)
        addSubview(editingButton)
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
            setsUnderline.topAnchor.constraint(equalTo: setStackView.bottomAnchor, constant: 2),
            setsUnderline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsUnderline.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            setsUnderline.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            repsStackView.topAnchor.constraint(equalTo: setStackView.bottomAnchor, constant: 20),
            repsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            repsStackView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            repsUnderline.topAnchor.constraint(equalTo: repsStackView.bottomAnchor, constant: 2),
            repsUnderline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsUnderline.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            repsUnderline.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            editingButton.topAnchor.constraint(equalTo: repsUnderline.bottomAnchor, constant: 10),
            editingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
         
        ])
        
    }
}
