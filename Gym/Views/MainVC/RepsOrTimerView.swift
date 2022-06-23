//
//  RepsOrTimerView.swift
//  Gym
//
//  Created by Андрей Яфаркин on 13.06.2022.
//

import Foundation
import UIKit

class RepsOrTimerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let setsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sets"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        return label
    }()
    
     let valueOfSetsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        return label
    }()
    
     let setsSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.isContinuous = true
        slider.tintColor = .speciakGreen
        slider.value = 0
        slider.addTarget(self, action: #selector(setSliderValuseChanged), for: .valueChanged)
        return slider
    }()
    
    @objc private func setSliderValuseChanged() {
        valueOfSetsLabel.text = "\(Int(setsSlider.value))"
    }
    
    private let chooseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose repeat or timer"
        label.textColor = .specilaLightBrown
        label.font = .robotoMedium12()
        return label
    }()
    
    private var setStackView = UIStackView()
    
    private let repsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reps"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        return label
    }()
    
     let valueOfRepsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        return label
    }()
    
     let repsSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.isContinuous = true
        slider.tintColor = .speciakGreen
        slider.value = 0
        slider.addTarget(self, action: #selector(repsSliderValuseChanged), for: .valueChanged)
        return slider
    }()
    
    @objc private func repsSliderValuseChanged() {
        setNegative(label: timerLabel, valueLabel: valueOfTimerLabel, slider: timerSlider)
        setActive(label: repsLabel, valueLabel: valueOfRepsLabel, slider: repsSlider)
        valueOfRepsLabel.text = "\(Int(repsSlider.value))"
    }
    
    private var repsStackView = UIStackView()
    
    private let timerLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Timer"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        return label
    }()
    
     let valueOfTimerLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 min"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        return label
    }()
    
     let timerSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 3599
        slider.isContinuous = true
        slider.tintColor = .speciakGreen
        slider.value = 0
        slider.addTarget(self, action: #selector(timerSliderValuseChanged), for: .valueChanged)
        return slider
    }()
    
    @objc private func timerSliderValuseChanged() {
        
        //        repsLabel.alpha = 0.5
        //        valueOfRepsLabel.alpha = 0.5
        //        repsSlider.alpha = 0.5
        //
        //        valueOfRepsLabel.text = "0"
        //        repsSlider.value = 0
        
        setNegative(label: repsLabel, valueLabel: valueOfRepsLabel, slider: repsSlider)
        
        //        timerLabel.alpha = 1
        //        valueOfTimerLabel.alpha = 1
        //        timerSlider.alpha = 1
        setActive(label: timerLabel, valueLabel: valueOfTimerLabel, slider: timerSlider)
        
        //настройка лейбла - в кложуре берем значение в секундах и переводим в минуты и секнуды
        let (min, sec) = { (sec:Int) -> (Int, Int) in
            return (sec / 60, (sec % 3600) % 60)}(Int(timerSlider.value))
        
        valueOfTimerLabel.text = (sec != 0 ? "\(min) min \(sec) sec" : "\(min) min")
    }
    
    private func setActive(label: UILabel, valueLabel: UILabel, slider: UISlider){
        label.alpha = 1
        valueLabel.alpha = 1
        slider.alpha = 1
    }
    
    private func setNegative(label: UILabel, valueLabel: UILabel, slider: UISlider){
        label.alpha = 0.5
        valueLabel.alpha = 0.5
        slider.alpha = 0.5
        valueLabel.text = "0"
        slider.value = 0
    }
    
    private var timerStackView = UIStackView()
    
    private func setupViews(){
        backgroundColor = .specialBrown
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        addSubview(setsLabel)
        setStackView = UIStackView(arrangeSubviews: [setsLabel, valueOfSetsLabel], axis: .horizontal, spacing: 10)
        addSubview(setStackView)
        addSubview(setsSlider)
        addSubview(chooseLabel)
        repsStackView = UIStackView(arrangeSubviews: [repsLabel, valueOfRepsLabel], axis: .horizontal, spacing: 10)
        addSubview(repsStackView)
        addSubview(repsSlider)
        timerStackView = UIStackView(arrangeSubviews: [timerLabel, valueOfTimerLabel], axis: .horizontal, spacing: 10)
        addSubview(timerStackView)
        addSubview(timerSlider)
    }
    
}

//MARK: - Set Constrints
extension RepsOrTimerView{
    private func setConstraints() {
        NSLayoutConstraint.activate([
            setStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            setStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            setsSlider.topAnchor.constraint(equalTo: setStackView.bottomAnchor, constant: 10),
            setsSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            chooseLabel.topAnchor.constraint(equalTo: setsSlider.bottomAnchor, constant: 10),
            chooseLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            repsStackView.topAnchor.constraint(equalTo: chooseLabel.bottomAnchor, constant: 10),
            repsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            repsSlider.topAnchor.constraint(equalTo: repsStackView.bottomAnchor, constant: 10),
            repsSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            timerStackView.topAnchor.constraint(equalTo: repsSlider.bottomAnchor, constant: 20),
            timerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            timerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            timerSlider.topAnchor.constraint(equalTo: timerStackView.bottomAnchor, constant: 10),
            timerSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            timerSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
