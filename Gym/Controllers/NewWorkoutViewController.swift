//
//  NewWorkoutViewController.swift
//  Gym
//
//  Created by Андрей Яфаркин on 12.06.2022.
//

import UIKit

class NewWorkoutViewController: UIViewController {
    
    private let headerLabel: UILabel = {
       let label = UILabel()
        label.text =  "NEW WORKOUT"
        label.textColor = .specialBlack
        label.textAlignment = .center
        label.font = .robotoBold20()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }
    
    
    
    private func setupView() {
        view.backgroundColor = .specialbackground
        view.addSubview(headerLabel)
    }
    
   
}
extension NewWorkoutViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
        
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
           
            
        ])
    }
}
