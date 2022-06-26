//
//  DateAndRepeatView.swift
//  Gym
//
//  Created by Андрей Яфаркин on 12.06.2022.
//

import UIKit

class DateAndRepeatView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date"
        label.textColor = .specialGray
        label.font = .robotoMedium18
        return label
    }()
    
     let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.tintColor = .speciakGreen
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let repeatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Repeat every 7 days"
        label.textColor = .specialGray
        label.font = .robotoMedium18
        return label
    }()
    
     let switcherRepeat: UISwitch = {
        let switchRepeat = UISwitch()
        switchRepeat.isOn = true
        switchRepeat.onTintColor = .speciakGreen
        switchRepeat.translatesAutoresizingMaskIntoConstraints = false
        return switchRepeat
    }()
    
    private var dateLabelStackView = UIStackView()
    private var switckStackView = UIStackView()
    
    //MARK: - Setup View
    private func setupView() {
        backgroundColor = .specialBrown
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        addSubview(dateLabel)
        dateLabelStackView = UIStackView(arrangeSubviews: [dateLabel, datePicker], axis: .horizontal, spacing: 10)
        addSubview(dateLabelStackView)
        switckStackView = UIStackView(arrangeSubviews: [repeatLabel, switcherRepeat], axis: .horizontal, spacing: 10)
        addSubview(switckStackView)
        
    }
}

//MARK: - Set Constraints

extension DateAndRepeatView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dateLabelStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dateLabelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            dateLabelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            switckStackView.topAnchor.constraint(equalTo: dateLabelStackView.bottomAnchor, constant: 10),
            switckStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            switckStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            
        ])
    }
}

