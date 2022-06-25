//
//  StartWorkoutViewController.swift
//  Gym
//
//  Created by Андрей Яфаркин on 25.06.2022.
//

import UIKit

class StartWorkoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        
    }
    
    private let startWorkoutLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "START WORKOUT"
        label.textColor = .specialBlack
        label.font = .robotoMedium24()
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
    
    private let sportsmanImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "sportsman")
        return image
    }()

}


//MARK: - Setup Views
extension StartWorkoutViewController {
    private func setupViews() {
        view.backgroundColor = .specialbackground
        view.addSubview(startWorkoutLabel)
        view.addSubview(closeButton)
        view.addSubview(sportsmanImage)
    }
}

//MARK: - SetConstraints

extension StartWorkoutViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            startWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            startWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
         ])
        
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: startWorkoutLabel.centerYAnchor, constant: 0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            sportsmanImage.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 10),
            sportsmanImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
         ])
    }
}

