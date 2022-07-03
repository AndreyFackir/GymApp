//
//  StatisticTableViewCell.swift
//  Gym
//
//  Created by Андрей Яфаркин on 29.06.2022.
//

import UIKit

class StatisticTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let exercizeNameLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Biceps"
        element.font = .robotoMedium18
        return element
    }()
    
    private let beforeLabel = UILabel(text: "Before: 18")
    private let nowLabel = UILabel(text: "Now: 20")
    private var beforeNowStackView = UIStackView()
    
    private let diffValueLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "+2"
        element.textColor = .specialGreen
        element.font = .robotoMedium18
        return element
    }()

}


//MARK: - setupViews
extension StatisticTableViewCell {
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubview(exercizeNameLabel)
        beforeNowStackView = UIStackView(arrangeSubviews: [beforeLabel, nowLabel], axis: .horizontal, spacing: 10)
        addSubview(beforeNowStackView)
        addSubview(diffValueLabel)
    }
}

//MARK: - setConstraints
extension StatisticTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            exercizeNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            exercizeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            exercizeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25)
        ])
        
        NSLayoutConstraint.activate([
            beforeNowStackView.topAnchor.constraint(equalTo: exercizeNameLabel.bottomAnchor, constant: 5),
            beforeNowStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            
        ])
        
        NSLayoutConstraint.activate([
            diffValueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            diffValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25)
            
        ])
    }
}
