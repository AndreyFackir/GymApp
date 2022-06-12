//
//  NewWorkoutViewController.swift
//  Gym
//
//  Created by Андрей Яфаркин on 12.06.2022.
//

import UIKit

class NewWorkoutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text =  "NEW WORKOUT"
        label.textColor = .specialBlack
        label.textAlignment = .center
        label.font = .robotoBold20()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let closeButton: UIButton = {
        let button =  UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Close Button"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
    }
    
    private let nameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Name"
        name.textColor = .specilaLightBrown
        name.font = .robotoMedium12()
        return name
    }()
    
    private let nameTextField: UITextField = {
        let text = UITextField()
        text.clearButtonMode = .always
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .specialBrown
        text.layer.cornerRadius = 10
        text.font = .robotoBold20()
        text.textColor = .specialGray
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: text.frame.height))
        text.leftViewMode = .always
        text.returnKeyType = .done
        return text
    }()
    
    private let dateAndRepeatLabel: UILabel = {
       let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date and Repeat"
        label.textColor = .specilaLightBrown
        label.font = .robotoMedium12()
        return label
    }()
    
    
//MARK: - SetupViews
    private func setupView() {
        view.backgroundColor = .specialbackground
        view.addSubview(headerLabel)
        view.addSubview(closeButton)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(dateAndRepeatLabel)
    }
}

//MARK: - SetConstrints
extension NewWorkoutViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor, constant: 0),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            dateAndRepeatLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            dateAndRepeatLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20)
        ])
    }
}
