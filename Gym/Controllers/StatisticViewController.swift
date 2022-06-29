//
//  StatisticViewController.swift
//  Gym
//
//  Created by Андрей Яфаркин on 20.06.2022.
//

import UIKit

class StatisticViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        
    }
    
    private let statisticLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "STATISTICS"
        label.textColor = .specialBlack
        label.font = .robotoMedium24
        return label
    }()
    
    private let segments: UISegmentedControl = {
        let element = UISegmentedControl(items: ["Week", "Month"])
        element.translatesAutoresizingMaskIntoConstraints = false
        element.selectedSegmentTintColor = .specialYellow
        element.selectedSegmentIndex = 0
        element.backgroundColor = .speciakGreen
        return element
    }()
    
    private let detailsLabel = UILabel(text: "Exercice")
    
   
    
    
}


//MARK: - SetupViews
extension StatisticViewController {
    
    private func setupViews() {
        view.backgroundColor = .specialbackground
        view.addSubview(statisticLabel)
        view.addSubview((segments))
    }
}

//MARK: - SetConstraints
extension StatisticViewController {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            statisticLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            statisticLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            segments.topAnchor.constraint(equalTo: statisticLabel.bottomAnchor, constant: 20),
            segments.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segments.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segments.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
