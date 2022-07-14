//
//  WorkoutTableViewCell.swift
//  Gym
//
//  Created by Андрей Яфаркин on 07.06.2022.
//

import UIKit

//для работы кнопки старт из ячейки создаем протокол
protocol StartWorkoutProtocol: AnyObject {
    func startButtonTapped(model: WorkoutModel)
}

class WorkoutTableViewCell: UITableViewCell {
    
    var workoutModel = WorkoutModel()
    
    //создаем переменную черз которую будем работать с протоколом, weak - чтобы не было утечки памяти
    weak var cellStartWorkoutDelegate: StartWorkoutProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let backgroundCell: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .specialBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let exersizeImage: UIImageView = {
        let exersizeImage = UIImageView()
        exersizeImage.translatesAutoresizingMaskIntoConstraints = false
        exersizeImage.image = UIImage(named: "Bell")
        exersizeImage.layer.cornerRadius = 20
        return exersizeImage
        
    }()
    
    private let square: UIView = {
        let square = UIView()
        square.translatesAutoresizingMaskIntoConstraints = false
        square.backgroundColor = .specialbackground
        square.layer.cornerRadius = 20
        return square
    }()
    
    private let exersizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Pull Ups"
        label.font = .robotoBold20
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let repsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reps: 20"
        label.font = .robotoMedium14
        label.textColor = .specialGray
        return label
    }()
    
    private let setsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sets: 2"
        label.font = .robotoMedium14
        label.textColor = .specialGray
        return label
    }()
    
    private let startButton:UIButton = {
        let start = UIButton(type: .system)
        start.translatesAutoresizingMaskIntoConstraints = false
        //start.setTitle("START", for: .normal)
        start.titleLabel?.font = .robotoBold16
        start.layer.cornerRadius = 10
       //start.backgroundColor = .specialYellow
       //start.tintColor = .specialDarkGreen
        start.addShadowOnView()
        start.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        return start
    }()
    
    @objc private func startButtonPressed() {
     
        
        //будем обращаться к методу протокола когда нажимаем на кнопку Старт, поэтому указываем
        cellStartWorkoutDelegate?.startButtonTapped(model: workoutModel)
      
    }
    
    func cellConfigure(model: WorkoutModel) {
        
        workoutModel = model
        //заполняем ячейку
        exersizeLabel.text = model.workoutName
        
        let (min, sec) = { (sec:Int) -> (Int, Int) in
            return (sec / 60, sec % 60)}(model.workoutTimer)
        
        repsCountLabel.text = (model.workoutTimer == 0 ? "Reps: \(model.workoutReps)" : "Timer: \(min) min \(sec) sec")
        setsCountLabel.text = "Sets: \(model.workoutSets)"
        
        //получаем изображение
        guard let imageData = model.workoutImage else { return }
        guard let image = UIImage(data: imageData) else { return }
        exersizeImage.image = image
        
        //конфиг в зависимости от стаутса( выполненно или нет)
        if model.status {
            startButton.setTitle("Complete", for: .normal)
            startButton.tintColor = .white
            startButton.backgroundColor = .specialGreen
            startButton.isEnabled = false
        } else {
            startButton.setTitle("Start", for: .normal)
            startButton.tintColor = .specialDarkGreen
            startButton.backgroundColor = .specialYellow
            startButton.isEnabled = true
        }
    }
    
    
   
    var labelStackView = UIStackView()
      
}

//MARK: - Setup Views

extension WorkoutTableViewCell{
    private func setupViews() {
        //прозрачный фон ячейки
        backgroundColor = .clear
        
        //убираем нажатие на ячейку и выделение
        selectionStyle = .none
        
        addSubview(backgroundCell)
        addSubview(square)
        addSubview(exersizeImage)
        addSubview(exersizeLabel)
        contentView.addSubview(startButton)
        labelStackView = UIStackView(arrangeSubviews: [repsCountLabel, setsCountLabel], axis: .horizontal, spacing: 10)
        addSubview(labelStackView)
        
        
    }
}

//MARK: - Set Constraints

extension WorkoutTableViewCell {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            square.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 10),
            square.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            square.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -10),
            square.widthAnchor.constraint(equalToConstant: 80),
            square.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            exersizeImage.centerXAnchor.constraint(equalTo: square.centerXAnchor),
            exersizeImage.centerYAnchor.constraint(equalTo: square.centerYAnchor),
            exersizeImage.heightAnchor.constraint(equalToConstant: 60),
            exersizeImage.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            exersizeLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 10),
            exersizeLabel.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 100)
        ])
        
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: exersizeLabel.bottomAnchor,constant: 0),
            labelStackView.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -1),
            labelStackView.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 100)
        ])
        
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: repsCountLabel.bottomAnchor, constant: 5),
            startButton.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 100),
            startButton.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            startButton.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -10)
        ])
    }
}
