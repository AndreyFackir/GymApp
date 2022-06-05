//
//  CalendarCollectionViewCell.swift
//  Gym
//
//  Created by Андрей Яфаркин on 05.06.2022.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    
    private let dayOfWeek: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "We"
        label.font = .robotoBold16()
        label.textColor = .white
        label.textAlignment = .center
        
        return label
        
    }()
    
    private let numberOfDayLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "29"
        label.font = .robotoBold20()
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
                dayOfWeek.textColor = .specialBlack
                numberOfDayLabel.textColor = .specialDarkGreen
                
            } else {
                backgroundColor = .speciakGreen
                dayOfWeek.textColor = .white
                numberOfDayLabel.textColor = .white
            }
        }
    }
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
            setConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        private func setupViews() {
            addSubview(dayOfWeek)
            addSubview(numberOfDayLabel)
            
        }
        
        private func setConstraints() {
            NSLayoutConstraint.activate([
                
                dayOfWeek.centerXAnchor.constraint(equalTo: centerXAnchor),
                dayOfWeek.topAnchor.constraint(equalTo: topAnchor, constant: 7)
                
                
            ])
            
            NSLayoutConstraint.activate([
                
                numberOfDayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                numberOfDayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
                
                
            ])
        }
    }
