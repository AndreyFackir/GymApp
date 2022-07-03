//
//  StatisticViewController.swift
//  Gym
//
//  Created by Андрей Яфаркин on 20.06.2022.
//

import UIKit

class ProfileViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PROFILE"
        label.textColor = .specialBlack
        label.font = .robotoMedium24
        return label
    }()
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(red: 194/255, green: 194/255, blue: 194/255, alpha: 1.0)
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLayoutSubviews() {
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.frame.width / 2
    }
    
    private let nameView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .specialGreen
        element.layer.cornerRadius = 10
        return element
    }()
    
    private let nameLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Andrey Fackir"
        element.font = .robotoMedium24
        element.textColor = .white
        return element
    }()
    
    private let heighLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Height: 181"
        element.textColor = .specialBlack
        element.font = .robotoMedium14
        return element
    }()
    
    private let weightLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Weight: 92"
        element.textColor = .specialBlack
        element.font = .robotoMedium14
        return element
    }()
    
    private lazy var editingButton: UIButton = {
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "pencil")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 5
        configuration.baseForegroundColor = .specialGreen
        configuration.contentInsets = .zero
        
        var text = AttributeContainer()
        text.font = .robotoMedium14
        configuration.attributedTitle = AttributedString("Editing", attributes: text)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction() {_ in
            print("editingButtonTapped")
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var heightWeightStack = UIStackView()
    
    
    
}

//MARK: - Setup Views
extension ProfileViewController {
    private func setupViews() {
        view.backgroundColor = .specialbackground
        view.addSubview(profileLabel)
        view.addSubview(nameView)
        view.addSubview(profilePhotoImageView)
        nameView.addSubview(nameLabel)
        view.addSubview(heighLabel)
        heightWeightStack = UIStackView(arrangeSubviews: [heighLabel, weightLabel], axis: .horizontal, spacing: 10)
        view.addSubview(heightWeightStack)
        view.addSubview(editingButton)
       
    }
}

//MARK: - Set Constrains
extension ProfileViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            profilePhotoImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 10),
            profilePhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            profilePhotoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 60),
            nameView.heightAnchor.constraint(equalToConstant: 100),
            nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: nameView.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: nameView.bottomAnchor, constant: -15)
        ])
        
        
        NSLayoutConstraint.activate([
            heightWeightStack.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 10),
            heightWeightStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            editingButton.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 10),
            editingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
       
    }
}
