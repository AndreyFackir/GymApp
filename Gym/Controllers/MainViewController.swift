//
//  ViewController.swift
//  Gym
//
//  Created by Андрей Яфаркин on 02.06.2022.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    
    //1 - создали элемент
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(red: 194/255, green: 194/255, blue: 194/255, alpha: 1.0)
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "User NameUser "
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.adjustsFontSizeToFitWidth = true // уменьшает шрифт в зависимотси от ширины лейбла
        label.minimumScaleFactor = 0.5 //на сколько может шрифт уменьшиться. Если 24, то будет 12 если не влезает в лейбл
        return label
    }()
    
    private let addWorkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.setTitle("Add Workout", for: .normal)
        button.titleLabel?.font = .robotoMedium12()
        button.setImage(UIImage(named: "addWorkout"), for: .normal)
        button.tintColor = .specialDarkGreen
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 15, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 50, left: -40, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(addWorkoutButtonTapped), for: .touchUpInside)
        button.addShadowOnView()
        return button
    }()
    
    private let workoutToday: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Workout Today"
        label.textColor = .specilaLightBrown
        label.font = .robotoMedium14()
        return label
    }()
    
    //1 - create tableView
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none //прозрачный
        //не оттягивается таблица
        tableView.bounces = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //убираем сепаратор у ячеек
        tableView.separatorStyle = .none
        //убираем индикатор прокрутки
        tableView.showsVerticalScrollIndicator = false
        tableView.isHidden = true
        return tableView
    }()
    
    private let noWorkoutImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Frame 1")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        //image.isHidden = false
        return image
    }()
    
    
    @objc private func addWorkoutButtonTapped() {
        let newWorkoutViewController = NewWorkoutViewController()
        //newWorkoutViewController.modalPresentationStyle = .fullScreen
        present(newWorkoutViewController, animated: true, completion: nil)
    }
    
    private let calendarView = CalendarView()
    private let weatherView = WeatherView()
    private let idWorkoutTableViewCell = "idWorkoutTableViewCell"
    
    
    //создаем объект реалма
    private let localRealm = try! Realm()
    //создаем массив для хранения данных с типом РЕЗАЛТС и в скобках модель которую хотим получить
    //сюда будут записывать все данные
    private let workoutArray: Results<WorkoutModel>! = nil
    
    //параметр ДЕЙТ нужен для подставления даты по нажатию на календарь
    private func getWorkouts(date: Date) {
        
        let calendar = Calendar.current //cоздаем календарь и выбираем наш календарь в заависимотси от нахождения устройства
        
        let components = calendar.dateComponents([.weekday], from: date) //массив викдей - номер дня, берем из дейт( входной параметр)
        
        guard let weekday = components.weekday else { return }
        print(weekday)
        
    }
    
   
    
    //из-за особенностей жиз цикла прописываем отделльный меотд для закругления
    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2 // делаем круг
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDelegates()
        //не забыть зарегистрировать ячейку!!!!
        tableView.register(WorkoutTableViewCell.self, forCellReuseIdentifier: idWorkoutTableViewCell)
        getWorkouts(date: Date()) //cегодншная дата
    }
    
    private func setupViews() {
        view.backgroundColor = .specialbackground
        view.addSubview(noWorkoutImage)
        //2 - добавили на экран элемент
        view.addSubview(calendarView)
        view.addSubview(userPhotoImageView)
        view.addSubview(userNameLabel)
        view.addSubview(addWorkoutButton)
        view.addSubview(weatherView)
        view.addSubview(workoutToday)
        view.addSubview(tableView)
        
    }
    
    private func setDelegates() {
        tableView.dataSource = self
        tableView.delegate  = self
    }
}

//MARK: - Set constraints

extension MainViewController {
    
    private func setConstraints() {
        
        //3 - настраиваем расположение(констрейнты) для элемента
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            userPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10), //отсутп справа и снизу всегда с минусом
            calendarView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: 10),
            userNameLabel.bottomAnchor.constraint(equalTo: calendarView.topAnchor, constant: -10),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            addWorkoutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            addWorkoutButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            addWorkoutButton.heightAnchor.constraint(equalToConstant: 80),
            addWorkoutButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            weatherView.leadingAnchor.constraint(equalTo: addWorkoutButton.trailingAnchor, constant: 10),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            weatherView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            workoutToday.topAnchor.constraint(equalTo: addWorkoutButton.bottomAnchor, constant: 10),
            workoutToday.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            workoutToday.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            noWorkoutImage.topAnchor.constraint(equalTo: workoutToday.bottomAnchor, constant: 10),
            noWorkoutImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: workoutToday.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
       
        
    }
}

//MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idWorkoutTableViewCell", for: indexPath) as! WorkoutTableViewCell
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //устанавливаем выоту ячейки
        return 100
        
    }
}
