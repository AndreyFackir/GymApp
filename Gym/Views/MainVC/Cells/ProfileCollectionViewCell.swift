//
//  ProfileCollectionViewCell.swift
//  Gym
//
//  Created by Андрей Яфаркин on 03.07.2022.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let exerciseCellName: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "TRICEPS"
        element.textColor = .white
        element.font = .robotoMedium18
        return element
    }()
    
    private let exerciseCellImage: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "Bell")
        element.tintColor = .white
        return element
    }()
    
    private let exersiceCellValue: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "240"
        element.textColor = .white
        element.font = .robotoBold40
        return element
    }()
    
     func cellConfigure(model: ResultWorkout) {
        exerciseCellName.text = model.name
        exersiceCellValue.text = "\(model.result)"
        
        guard let data = model.imageData else { return }
        let image = UIImage(data: data)
        exerciseCellImage.image = image
        
    }
    
}

//MARK: - Setup Views
extension ProfileCollectionViewCell {
    private func setupViews() {
//        backgroundColor = .specialGreen
        layer.cornerRadius = 20
        addSubview(exerciseCellName)
        addSubview(exerciseCellImage)
        addSubview(exersiceCellValue)
    }
}

extension ProfileCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            exerciseCellName.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            exerciseCellName.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            exerciseCellImage.topAnchor.constraint(equalTo: exerciseCellName.bottomAnchor, constant: 5),
            exerciseCellImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            exerciseCellImage.widthAnchor.constraint(equalToConstant: 60),
            exerciseCellImage.heightAnchor.constraint(equalToConstant: 60),
            exerciseCellImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            exersiceCellValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            exersiceCellValue.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
    }
}
