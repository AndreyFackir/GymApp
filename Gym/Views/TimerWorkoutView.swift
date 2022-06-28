//
//  TimerWorkoutView.swift
//  Gym
//
//  Created by Андрей Яфаркин on 27.06.2022.
//

import UIKit

class TimerWorkoutView: UIView {
    
    weak var nextSetDelegate: NextSetProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    let exercizeNameLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.text = "Squats"
       label.textColor = .specialBlack
       label.font = .robotoMedium24
       return label
   }()
    
    private let setsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sets"
        label.textColor = .specialGray
        label.font = .robotoMedium18
        return label
    }()
    
    let valueOfSetsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1/4"
        label.textColor = .specialGray
        label.font = .robotoMedium18
        return label
    }()
    
    private var setStackView = UIStackView()
    
    private let setsUnderline: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .specialLine
        return line
    }()
    
    private let repsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Time of Set"
        label.textColor = .specialGray
        label.font = .robotoMedium18
        return label
    }()
    
    let valueOfTimerLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1 min 30 sec"
        label.textColor = .specialGray
        label.font = .robotoMedium18
        return label
    }()
    
    private var repsStackView = UIStackView()
    
    private let repsUnderline: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .specialLine
        return line
    }()
    
    private lazy var editingButton: UIButton = {
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "pencil")
        configuration.imagePlacement = .leading
        configuration.imagePadding = 5
        configuration.baseForegroundColor = .specilaLightBrown
        configuration.contentInsets = .zero
        
        var text = AttributeContainer()
        text.font = .robotoMedium14
        configuration.attributedTitle = AttributedString("Editing", attributes: text)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction() {_ in
            print("editingButtonTapped")
         })
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private lazy var nextSetButton: UIButton = {
        
        var configuration  = UIButton.Configuration.filled()
        configuration.baseForegroundColor = .specialBlack
        configuration.baseBackgroundColor = .specialYellow
        configuration.contentInsets = .zero
        configuration.cornerStyle = .large
    
        var text = AttributeContainer()
        text.font = .robotoMedium18
        configuration.attributedTitle = AttributedString("Next Set", attributes: text)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction() { [self]_ in
            print("nextSetButtonTapped")
            nextSetDelegate?.nextSetTapped()
         })
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
}



//MARK: - setupViews
extension TimerWorkoutView {
    private func setupViews() {
        backgroundColor = .specialBrown
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        addSubview(exercizeNameLabel)
        setStackView = UIStackView(arrangeSubviews: [setsLabel, valueOfSetsLabel], axis: .horizontal, spacing: 10)
        addSubview(setStackView)
        addSubview(setStackView)
        addSubview(setsUnderline)
        repsStackView = UIStackView(arrangeSubviews: [repsLabel, valueOfTimerLabel], axis: .horizontal, spacing: 10)
        repsStackView.distribution = .equalSpacing
        addSubview(repsStackView)
        addSubview(repsUnderline)
        addSubview(editingButton)
        addSubview(nextSetButton)
    }
}

//MARK: - SetConstraints
extension TimerWorkoutView {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            exercizeNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            exercizeNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            setStackView.topAnchor.constraint(equalTo: exercizeNameLabel.bottomAnchor, constant: 10),
            setStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            setsUnderline.topAnchor.constraint(equalTo: setStackView.bottomAnchor, constant: 2),
            setsUnderline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsUnderline.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            setsUnderline.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            repsStackView.topAnchor.constraint(equalTo: setStackView.bottomAnchor, constant: 20),
            repsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            repsUnderline.topAnchor.constraint(equalTo: repsStackView.bottomAnchor, constant: 2),
            repsUnderline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsUnderline.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            repsUnderline.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            editingButton.topAnchor.constraint(equalTo: repsUnderline.bottomAnchor, constant: 10),
            editingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            nextSetButton.topAnchor.constraint(equalTo: editingButton.bottomAnchor, constant: 20),
            nextSetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            nextSetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            nextSetButton.heightAnchor.constraint(equalToConstant: 40)
         ])
    }
}
