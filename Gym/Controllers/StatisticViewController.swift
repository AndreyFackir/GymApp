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
        let element = UISegmentedControl()
        element.translatesAutoresizingMaskIntoConstraints = false
       
      
        
        return element
    }()
    
    
}


//MARK: - SetupViews
extension StatisticViewController {
    
    private func setupViews() {
        view.backgroundColor = .specialbackground
        view.addSubview(statisticLabel)
    }
}

//MARK: - SetConstraints
extension StatisticViewController {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            statisticLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            statisticLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
