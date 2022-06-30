//
//  StartWorkoutViewController.swift
//  Gym
//
//  Created by Андрей Яфаркин on 25.06.2022.
//

import UIKit
import SwiftUI

class StartWorkoutViewController: UIViewController {
    
    
    
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
    
    private let sportsmanImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "sportsman")
        return image
    }()
    
    private let detailsLabel = UILabel(text: "Details")
    
    private let startWorkoutView = StartWorkoutView()
    
    var workoutModel = WorkoutModel()
    
    let customAlert = CustomAlert()
    
    //2 - назанчам данный класс делегатом
    private func setDelegates() {
        startWorkoutView.cellNextSetDelegate = self
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setWorkoutParameters()
       setDelegates()
    }
    
    private lazy var finishButton: UIButton = {
        
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .large
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .specialDarkGreen
        
        var text = AttributeContainer()
        text.font = .robotoMedium18
        configuration.attributedTitle = AttributedString("FINISH", attributes: text)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction() {_ in
            print("FAF")
            
            //если количество сетов равно искомому количеству
            if self.numberOfSet == self.workoutModel.workoutSets {
                //закрываем экран
                self.dismiss(animated: true, completion: nil)
                //меняем статус модели на законченное упражнение
                RealmManager.shared.updateWorkoutModel(model: self.workoutModel, bool: true)
            } else {
                self.alertOkCancel(title: "Warning", message: "The exercise havent done yet") {
                    self.dismiss(animated: true)
                }
            }
            
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
      }()
     
    private var numberOfSet = 1
    
    private func setWorkoutParameters() {
        startWorkoutView.nameLabel.text = workoutModel.workoutName
        startWorkoutView.valueOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        startWorkoutView.valueOfRepsLabel.text = "\(workoutModel.workoutReps)"
    }
    
}

//1 - подписываемся под протокол и вызываем функцию
extension StartWorkoutViewController: NextSetProtocol {
    
    func editingTapped() {
        customAlert.alertCustom(viewController: self) { _, _ in
            print("a")
        }
    }
    
    func nextSetTapped() {
        print("nextSetTapped")
        
        if numberOfSet < workoutModel.workoutSets {
            numberOfSet += 1
            startWorkoutView.valueOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        } else {
            alertOK(title: "Congrats!", message: "Now you can finish your workout")
        }
    }
    
    
}
    


//MARK: - Setup Views
extension StartWorkoutViewController {
    private func setupViews() {
        view.backgroundColor = .specialbackground
        view.addSubview(startWorkoutLabel)
        view.addSubview(closeButton)
        view.addSubview(sportsmanImage)
        view.addSubview(detailsLabel)
        view.addSubview(startWorkoutView)
        view.addSubview(finishButton)
    }
}

//MARK: - SetConstraints

extension StartWorkoutViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            startWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            startWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: startWorkoutLabel.centerYAnchor, constant: 0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            sportsmanImage.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 20),
            sportsmanImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: sportsmanImage.bottomAnchor, constant: 20),
            detailsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            startWorkoutView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5),
            startWorkoutView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            startWorkoutView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            startWorkoutView.heightAnchor.constraint(equalToConstant: 225)
        ])
        
        NSLayoutConstraint.activate([
            finishButton.topAnchor.constraint(equalTo: startWorkoutView.bottomAnchor, constant: 40),
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
}

