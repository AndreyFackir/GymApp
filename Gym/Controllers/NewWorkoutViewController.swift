//
//  NewWorkoutViewController.swift
//  Gym
//
//  Created by Андрей Яфаркин on 12.06.2022.
//

import UIKit
import RealmSwift

class NewWorkoutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        setDelegates()
        addTaps()
    }
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text =  "NEW WORKOUT"
        label.textColor = .specialBlack
        label.textAlignment = .center
        label.font = .robotoBold20
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
    }
    
    //    private let nameLabel: UILabel = {
    //        let name = UILabel()
    //        name.translatesAutoresizingMaskIntoConstraints = false
    //        name.text = "Name"
    //        name.textColor = .specilaLightBrown
    //        name.font = .robotoMedium12()
    //        return name
    //    }()
    
    //то же что и запись выше, только с использование экстеншена для UILabel
    private let nameLabel = UILabel(text: "Name")
    
    private let nameTextField: UITextField = {
        let text = UITextField()
        text.clearButtonMode = .always
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .specialBrown
        text.layer.cornerRadius = 10
        text.font = .robotoBold20
        text.textColor = .specialGray
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: text.frame.height))
        text.leftViewMode = .always
        text.returnKeyType = .done
        return text
    }()
    
    private let dateAndRepeatLabel: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date and Repeat"
        label.textColor = .specilaLightBrown
        label.font = .robotoMedium12
        return label
    }()
    
    private let repsOrTimerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reps or timer"
        label.textColor = .specilaLightBrown
        label.font = .robotoMedium12
        return label
    }()
    
    private let dateAndRepeatView = DateAndRepeatView()
    private let repsOrTimerView = RepsOrTimerView()
    
    private let localRealm = try! Realm()
    
    //создаем модель
    var workoutModel = WorkoutModel()
    
    private let testImage = UIImage(named: "Bell")
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SAVE", for: .normal)
        button.titleLabel?.font = .robotoMedium18
        button.tintColor = .white
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        button.backgroundColor = .speciakGreen
        button.layer.cornerRadius = 10
        return button
    }()
    
    @objc func saveButtonPressed() {
        print("saveButtonPressed")
        print(workoutModel)
        setModel()
        print(workoutModel)
        saveModel()
        print(workoutModel)
    }
    
    private func setDelegates() {
        nameTextField.delegate = self
    }
    
    
    private func addTaps() {
        //скрываем клаву по тапу
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapScreen)
    }
    
    @objc private func hideKeyboard(){
        view.endEditing(true)
    }
    
    
    private func setModel() {
        //1 - берем имя из текстфилда в БД
        guard let nameWorkout = nameTextField.text else { return }
        workoutModel.workoutName = nameWorkout
        
        //берем дату
        workoutModel.workoutDate = dateAndRepeatView.datePicker.date
        // берем день недели
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: dateAndRepeatView.datePicker.date)
        guard let weekday = components.weekday else { return }
        workoutModel.workoutNumberOfDay = weekday
        
        //берем положение свитча
        workoutModel.workoutRepeats = dateAndRepeatView.switcherRepeat.isOn
        
        //берем сеты, репсы
        workoutModel.workoutSets = Int(repsOrTimerView.setsSlider.value)
        workoutModel.workoutReps = Int(repsOrTimerView.repsSlider.value)
        workoutModel.workoutTimer = Int(repsOrTimerView.timerSlider.value)
        
        guard let imageData = testImage?.pngData() else { return }
        workoutModel.workoutImage = imageData
    }
    
    //сохраняем модель в БД
    private func saveModel() {
       
        //проверка на то, что в текстифлд написаны буквы или цифры( пробелы не считаются)
        guard let text = nameTextField.text else { return }
        let count = text.filter { $0.isNumber || $0.isLetter }.count
        print(count)
        
        //если строка не пустая(количесвто символов не 0), то сохраняем в БД
        if count != 0 && workoutModel.workoutSets != 0 && (workoutModel.workoutReps != 0 || workoutModel.workoutTimer != 0){
            
            RealmManager.shared.saveWorkoutModel(model: workoutModel)
           
            //после записи в БД сразу обновляем модель, иначе если нажать два раза подряд выпадет ошибка
            workoutModel = WorkoutModel()
            alertOK(title: "Sucsess", message: nil)
            //обнуляем все лейблы
            refreshWorkoutObject()
            
        } else {
            alertOK(title: "Attensione", message: "Fill all parameters")
            
        }
        
    }
    
    
    private func refreshWorkoutObject() {
        //устанавливаем дату на данный момент
        dateAndRepeatView.datePicker.setDate(Date(), animated: true)
        nameTextField.text = ""
        dateAndRepeatView.switcherRepeat.isOn = true
        repsOrTimerView.valueOfSetsLabel.text = "0"
        repsOrTimerView.setsSlider.value = 0
        repsOrTimerView.valueOfRepsLabel.text = "0"
        repsOrTimerView.repsSlider.value = 0
        repsOrTimerView.timerSlider.value = 0
        repsOrTimerView.valueOfTimerLabel.text = "0 min"
    }
    
    
    //MARK: - SetupViews
    private func setupView() {
        view.backgroundColor = .specialbackground
        view.addSubview(headerLabel)
        view.addSubview(closeButton)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(dateAndRepeatLabel)
        view.addSubview(dateAndRepeatView)
        view.addSubview(repsOrTimerLabel)
        view.addSubview(repsOrTimerView)
        view.addSubview(saveButton)
    }
}


//MARK: - UITextFieldDelegate
extension NewWorkoutViewController: UITextFieldDelegate {
    // чтобы клава убиралась по нажатию на кнопку done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
    }
    
}
//MARK: - SetConstrints
extension NewWorkoutViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor, constant: 0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            dateAndRepeatLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            dateAndRepeatLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            dateAndRepeatView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            dateAndRepeatView.topAnchor.constraint(equalTo: dateAndRepeatLabel.bottomAnchor, constant: 5),
            dateAndRepeatView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateAndRepeatView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateAndRepeatView.heightAnchor.constraint(equalToConstant: 94)
        ])
        
        NSLayoutConstraint.activate([
            repsOrTimerLabel.topAnchor.constraint(equalTo: dateAndRepeatView.bottomAnchor, constant: 15),
            repsOrTimerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            
        ])
        
        NSLayoutConstraint.activate([
            repsOrTimerView.topAnchor.constraint(equalTo: repsOrTimerLabel.bottomAnchor, constant: 5),
            repsOrTimerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repsOrTimerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            repsOrTimerView.heightAnchor.constraint(equalToConstant: 280)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: repsOrTimerView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}




