//
//  EditingProfileViewController.swift
//  Gym
//
//  Created by Андрей Яфаркин on 04.07.2022.
//

import UIKit

class EditingProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    private let editingProfileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "EDITING PROFILE"
        label.textColor = .specialBlack
        label.font = .robotoMedium24
        return label
    }()
    
    private lazy var profilePhotoButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = UIColor(red: 194/255, green: 194/255, blue: 194/255, alpha: 1.0)
        configuration.cornerStyle = .capsule
        configuration.image = UIImage(systemName: "person.crop.circle.badge.plus")
       
        let button = UIButton(configuration: configuration, primaryAction: UIAction() {_ in
            print("profilePhotoButtonTapped")
            
        })
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
           
    private let emptyView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .specialGreen
        element.layer.cornerRadius = 10
        return element
    }()
    
    private let firstNameLabel = UILabel(text: "FirstName")
    
    private let firstNameTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.clearButtonMode = .always
        element.backgroundColor = .specialBrown
        element.layer.cornerRadius = 10
        element.font = .robotoBold20
        element.textColor = .specialGray
        element.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: element.frame.height))
        element.leftViewMode = .always
        element.returnKeyType = .done
        return element
    }()
    
    
}

//MARK: -  setupViews
extension EditingProfileViewController {
    private func setupViews() {
        view.backgroundColor = .specialbackground
        view.addSubview(editingProfileLabel)
        view.addSubview(emptyView)
        view.addSubview(profilePhotoButton)
        view.addSubview(firstNameLabel)
        view.addSubview(firstNameTextField)
       
    }
}

//MARK: - SetConstraints
extension EditingProfileViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            editingProfileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            editingProfileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            profilePhotoButton.topAnchor.constraint(equalTo: editingProfileLabel.bottomAnchor, constant: 10),
            profilePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePhotoButton.heightAnchor.constraint(equalToConstant: 100),
            profilePhotoButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: editingProfileLabel.bottomAnchor, constant: 60),
            emptyView.heightAnchor.constraint(equalToConstant: 100),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            firstNameLabel.topAnchor.constraint(equalTo: emptyView.bottomAnchor, constant: 30),
            firstNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            firstNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 5),
            firstNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firstNameLabel.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
}
