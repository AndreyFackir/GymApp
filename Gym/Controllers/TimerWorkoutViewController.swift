//
//  TimerWorkoutViewController.swift
//  Gym
//
//  Created by Андрей Яфаркин on 27.06.2022.
//

import UIKit

class TimerWorkoutViewController: UIViewController {
    
    var workoutModel = WorkoutModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setParameters()
        timerWorkoutView.nextSetDelegate = self
        addaps()
    }
    
    private let startWorkoutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "START WORKOUT"
        label.textColor = .specialBlack
        label.font = .robotoMedium24
        return label
    }()
    
    private let closeButton: UIButton = {
        let button =  UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Close Button"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private let timerImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Ellipse")
        return image
    }()
    
    private let timerLabel: UILabel = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "01:30"
        $0.font = .robotoBold50
        return $0
    }(UILabel())
    
    private let detailsLabel = UILabel(text: "Details")
    
    private let timerWorkoutView = TimerWorkoutView()
    
    private lazy var finishButton: UIButton = {
        
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .large
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .specialDarkGreen
        
        var text = AttributeContainer()
        text.font = .robotoMedium18
        configuration.attributedTitle = AttributedString("FINISH", attributes: text)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction() { [self]_ in
            print("FAF")
            
            if setNumber == workoutModel.workoutSets {
                dismiss(animated: true)
                RealmManager.shared.updateStatusWorkoutModel(model: workoutModel, bool: true)
            } else {
                alertOkCancel(title: "Warning", message: "The excercize havent done yet") {
                    dismiss(animated: true)
                }
            }
            
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var setNumber = 1
    private func setParameters() {
        timerWorkoutView.valueOfSetsLabel.text = "\(setNumber)/\(workoutModel.workoutSets)"
        
        let (min, sec) = {(sec: Int) -> (Int, Int) in
            
            return (sec / 60, sec % 60)
        }(workoutModel.workoutTimer)
        
        timerWorkoutView.valueOfTimerLabel.text = "\(min) min \(sec) sec"
        timerLabel.text = "\(min):\(sec)"
        timerWorkoutView.exercizeNameLabel.text = workoutModel.workoutName
        
    }
    
    //создаем таймер
    var timer = Timer()
    var durationTimer = 10
    
    //запускаем таймер по тапу на лейбл
    private func addaps() {
        let tapLabel = UITapGestureRecognizer(target: self, action: #selector(startTimer))
        timerLabel.isUserInteractionEnabled = true
        timerLabel.addGestureRecognizer(tapLabel)
    }
    
    @objc private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc private func timerAction() {
        
        durationTimer -= 1
        
        
        if durationTimer == 0 {
            print(durationTimer)
            timer.invalidate()
        }
    }
    
}




//MARK: - NextSetProtocol
extension TimerWorkoutViewController: NextSetProtocol {
    func editingTapped() {
        print("3")
    }
    
    func nextSetTapped() {
        if setNumber < workoutModel.workoutSets {
            setNumber += 1
            timerWorkoutView.valueOfSetsLabel.text = "\(setNumber)/\(workoutModel.workoutSets)"
        } else {
            alertOK(title: "Congras", message: "You finished your work")
        }
    }
}

//MARK: - Setup Views
extension TimerWorkoutViewController {
    private func setupViews() {
        view.backgroundColor = .specialbackground
        view.addSubview(startWorkoutLabel)
        view.addSubview(closeButton)
        view.addSubview(timerImage)
        view.addSubview(timerLabel)
        view.addSubview(detailsLabel)
        view.addSubview(timerWorkoutView)
        view.addSubview(finishButton)
    }
}

//MARK: - SetConstraints
extension TimerWorkoutViewController {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            startWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            startWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: timerImage.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: timerImage.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: startWorkoutLabel.centerYAnchor, constant: 0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            timerImage.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 30),
            timerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: timerImage.bottomAnchor, constant: 20),
            detailsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            timerWorkoutView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5),
            timerWorkoutView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            timerWorkoutView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            timerWorkoutView.heightAnchor.constraint(equalToConstant: 225)
        ])
        
        NSLayoutConstraint.activate([
            finishButton.topAnchor.constraint(equalTo: timerWorkoutView.bottomAnchor, constant: 40),
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
