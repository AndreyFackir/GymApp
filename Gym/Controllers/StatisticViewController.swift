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
        setDelegates()
        
    }
    
    private let idStatisticTableViewCell = "idStatisticTableViewCell"
    
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
    
    private let exerciseLabel = UILabel(text: "Exercices")

    private let tableWithParametrs: UITableView = {
        let element = UITableView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .specialbackground
        element.bounces = false
        element.showsVerticalScrollIndicator = false
        return element
    }()
    
    


}


//MARK: - setDelegates
extension StatisticViewController {
    
    private func setDelegates() {
        tableWithParametrs.dataSource = self
        tableWithParametrs.delegate = self
        tableWithParametrs.register(StatisticTableViewCell.self, forCellReuseIdentifier: idStatisticTableViewCell)
    }
}

//MARK: - SetupViews
extension StatisticViewController {
    
    private func setupViews() {
        view.backgroundColor = .specialbackground
        view.addSubview(statisticLabel)
        view.addSubview(segments)
        view.addSubview(exerciseLabel)
        view.addSubview(tableWithParametrs)
    }
}

//MARK: - UITableViewDataSource
extension StatisticViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idStatisticTableViewCell, for: indexPath) as! StatisticTableViewCell
        
        return cell
    }
    
}


//MARK: - UITableViewDelegate

extension StatisticViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
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
        
        NSLayoutConstraint.activate([
            exerciseLabel.topAnchor.constraint(equalTo: segments.bottomAnchor, constant: 20),
            exerciseLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            tableWithParametrs.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor, constant: 0),
            tableWithParametrs.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableWithParametrs.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableWithParametrs.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
       
       
    }
}
