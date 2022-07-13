//
//  OnboardingCollectionViewCell.swift
//  Gym
//
//  Created by Андрей Яфаркин on 13.07.2022.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let topLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Have a good helath"
        element.textColor = .specialGreen
        element.font = .robotoBold20
        element.textAlignment = .center
        return element
    }()
    
    private let image: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "onboardingFirst")
        element.contentMode = .scaleAspectFill
        return element
    }()
    
    private let bottomLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Being healthy is all"
        element.textColor = .white
        element.font = .robotoMedium18
        element.textAlignment = .center
        element.numberOfLines = 4
        return element
    }()
    
     func cellConfigure(model: OnboardingModel) {
        topLabel.text = model.topLabel
        bottomLabel.text = model.bottomLabel
        image.image = model.image
    }
}

//MARK: - setupViews
extension OnboardingCollectionViewCell {
    private func setupViews() {
        backgroundColor = .specialGreen
        addSubview(image)
        addSubview(topLabel)
        addSubview(bottomLabel)
    }
}

//MARK: - setConstraints
extension OnboardingCollectionViewCell {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            image.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 0),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            image.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            topLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            topLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            bottomLabel.heightAnchor.constraint(equalToConstant: 85)
        ])
    }
}
