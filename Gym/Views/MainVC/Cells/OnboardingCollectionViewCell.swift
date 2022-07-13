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
        return element
    }()
    
    private let image: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "onboardingFirst")
        return element
    }()
    
    private let bottomLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Being healthy is all"
        element.textColor = .specialGreen
        element.font = .robotoBold20
        return element
    }()
    
}

//MARK: - setupViews
extension OnboardingCollectionViewCell {
    private func setupViews() {
        backgroundColor = .blue
        addSubview(topLabel)
        addSubview(image)
        addSubview(bottomLabel)
    }
}

//MARK: - setConstraints
extension OnboardingCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
            topLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            topLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            image.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 0),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            image.heightAnchor.constraint(equalTo: heightAnchor, constant: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            bottomLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
