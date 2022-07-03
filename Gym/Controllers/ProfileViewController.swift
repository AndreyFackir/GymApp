//
//  StatisticViewController.swift
//  Gym
//
//  Created by Андрей Яфаркин on 20.06.2022.
//

import UIKit
import RealmSwift

class ProfileViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDelegates()
        exersizeCollectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: profileCollectionViewCell)
        
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
    
    private let exersizeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .none
        
        return collectionView
    }()
    
    private let profileCollectionViewCell = "profileCollectionViewCell"
    
    private let targetLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Target: 20 workouts"
        element.textColor = .specialBlack
        element.font = .robotoBold16
        return element
    }()
    
    private let startProgressLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textColor = .specialBlack
        element.text = "0"
        element.font = .robotoMedium18
        return element
    }()
    
    private let endProgressLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textColor = .specialBlack
        element.text = "20"
        element.font = .robotoMedium18
        return element
    }()
    
    private var starEndStackView = UIStackView()
    
    private let progressBar: UIProgressView = {
        let element = UIProgressView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.progressTintColor = .specialGreen
        element.layer.cornerRadius = 5
        element.setProgress(0.5, animated: false)
        return element
    }()
    
}


//MARK: - UICollectionViewDataSource

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        
        
        cell.backgroundColor = .specialGreen
        
        
        return cell
    }
    
    
}

//MARK: - UICollectionViewDelegate
extension ProfileViewController: UICollectionViewDelegate {
    
    
    
}

//MARK: - UICollectionViewFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: 190, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        3
    }
   
    
}

extension ProfileViewController {
    private func setDelegates() {
        exersizeCollectionView.delegate = self
        exersizeCollectionView.dataSource = self
    }
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
        view.addSubview(exersizeCollectionView)
        view.addSubview(targetLabel)
        view.addSubview(progressBar)
        starEndStackView = UIStackView(arrangeSubviews: [startProgressLabel, endProgressLabel], axis: .horizontal, spacing: 10)
        view.addSubview(starEndStackView)
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
        
        NSLayoutConstraint.activate([
            exersizeCollectionView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 50),
            exersizeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exersizeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            exersizeCollectionView.widthAnchor.constraint(equalToConstant: 300),
            exersizeCollectionView.heightAnchor.constraint(equalToConstant: 220)
        ])
       
        NSLayoutConstraint.activate([
            targetLabel.topAnchor.constraint(equalTo: exersizeCollectionView.bottomAnchor, constant: 10),
            targetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            starEndStackView.topAnchor.constraint(equalTo: targetLabel.bottomAnchor, constant: 25),
            starEndStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            starEndStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: starEndStackView.bottomAnchor, constant: 5),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            progressBar.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
}
