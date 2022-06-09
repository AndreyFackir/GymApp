//
//  WorkoutTableViewCell.swift
//  Gym
//
//  Created by Андрей Яфаркин on 07.06.2022.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {
    
    private let backgroundCell: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .specialBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let exersizeImage: UIImageView = {
        let exersizeImage = UIImageView()
        exersizeImage.translatesAutoresizingMaskIntoConstraints = false
        exersizeImage.image = UIImage(named: "Bell")
        exersizeImage.layer.cornerRadius = 20
        return exersizeImage
        
    }()
    
    private let square: UIView = {
        let square = UIView()
        square.translatesAutoresizingMaskIntoConstraints = false
        square.backgroundColor = .specialbackground
        square.layer.cornerRadius = 20
        return square
    }()
    
    private let exersizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Pull Ups"
        label.font = .robotoBold20()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let repsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reps: 20"
        label.font = .robotoMedium14()
        label.textColor = .specialGray
        return label
    }()
    
    private let setsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sets: 2"
        label.font = .robotoMedium14()
        label.textColor = .specialGray
        return label
    }()
    
    private let startButton:UIButton = {
        let start = UIButton(type: .system)
        start.translatesAutoresizingMaskIntoConstraints = false
        start.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        start.setTitle("START", for: .normal)
        start.titleLabel?.font = .robotoBold16()
        start.layer.cornerRadius = 10
        start.backgroundColor = .specialYellow
        start.tintColor = .specialDarkGreen
        start.addShadowOnView()
        return start
    }()
    
    @objc private func startButtonPressed() {
        print("Start button is pressed")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        //прозрачный фон ячейки
        backgroundColor = .clear
        
        //убираем нажатие на ячейку и выделение
        selectionStyle = .none
        
        addSubview(backgroundCell)
       
        addSubview(square)
        addSubview(exersizeImage)
        addSubview(exersizeLabel)
        addSubview(repsCountLabel)
        addSubview(startButton)
        addSubview(setsCountLabel)
        contentView.isUserInteractionEnabled = false
       
        
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            square.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 10),
            square.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            square.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -10),
            square.widthAnchor.constraint(equalToConstant: 80),
            square.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            exersizeImage.topAnchor.constraint(equalTo: square.topAnchor, constant: 5),
            exersizeImage.leadingAnchor.constraint(equalTo: square.leadingAnchor, constant: 12),
            exersizeImage.bottomAnchor.constraint(equalTo: square.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            exersizeLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 10),
            exersizeLabel.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 100)
        ])
        
        NSLayoutConstraint.activate([
            repsCountLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -1),
            repsCountLabel.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 100)
        ])
        
        NSLayoutConstraint.activate([
            setsCountLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -1),
            setsCountLabel.leadingAnchor.constraint(equalTo: repsCountLabel.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: repsCountLabel.bottomAnchor, constant: 5),
            startButton.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 100),
            startButton.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            startButton.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -10)
        ])
    }
    
}
