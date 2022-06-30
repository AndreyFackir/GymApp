//
//  CalendarCollectionViewCell.swift
//  Gym
//
//  Created by Андрей Яфаркин on 05.06.2022.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private let dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "We"
        label.font = .robotoBold16
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
     let numberOfDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "29"
        label.font = .robotoBold20
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    //когда ячейка выбрана будем производить какие то действия
    override var isSelected: Bool {
        
        didSet {
            if self.isSelected{
                backgroundColor = .specialYellow
                layer.cornerRadius = 10
                dayOfWeekLabel.textColor = .specialBlack
                numberOfDayLabel.textColor = .specialDarkGreen
                
            } else {
                backgroundColor = .speciakGreen
                dayOfWeekLabel.textColor = .white
                numberOfDayLabel.textColor = .white
            }
        }
    }
    
    func cellConfigure(numberOfDay: String, dayOfWeek: String) {
        numberOfDayLabel.text = numberOfDay
        dayOfWeekLabel.text = dayOfWeek
    }
 }

//MARK: -  Setup Views
extension CalendarCollectionViewCell {
    private func setupViews() {
        addSubview(dayOfWeekLabel)
        addSubview(numberOfDayLabel)
        
    }
}
//MARK: - SetConstraints

extension CalendarCollectionViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dayOfWeekLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dayOfWeekLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7)
        ])
        
        NSLayoutConstraint.activate([
            numberOfDayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberOfDayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}

