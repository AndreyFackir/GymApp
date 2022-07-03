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
        label.font = .robotoMedium24
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
        button.titleLabel?.font = .robotoMedium12
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
        label.font = .robotoMedium14
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
        return tableView
    }()
    
    private let noWorkoutImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Frame 1")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    @objc private func addWorkoutButtonTapped() {
        let newWorkoutViewController = NewWorkoutViewController()
        newWorkoutViewController.modalPresentationStyle = .fullScreen
        present(newWorkoutViewController, animated: true, completion: nil)
       
    }
    
   
    
    private let calendarView = CalendarView()
    private let weatherView = WeatherView()
    private let idWorkoutTableViewCell = "idWorkoutTableViewCell"
    
    var workoutModel = WorkoutModel()
    
    //создаем объект реалма
    private let localRealm = try! Realm()
    //создаем массив для хранения данных с типом РЕЗАЛТС и в скобках модель которую хотим получить
    //сюда будут записывать все данные
    private var workoutArray: Results<WorkoutModel>! 
    
    //параметр ДЕЙТ нужен для подставления даты по нажатию на календарь
    private func getWorkouts(date: Date) {
        
//        let calendar = Calendar.current //cоздаем календарь и выбираем наш календарь в заависимотси от нахождения устройства
//
//        let formatter = DateFormatter()
//
//        let components = calendar.dateComponents([.weekday, .day, .month, .year], from: date) //массив викдей - номер дня, берем из дейт( входной параметр)
//
//        guard let weekday = components.weekday else { return }
//        guard let day = components.day else { return }
//        guard let month = components.month else { return }
//        guard let year = components.year else { return }
//        print(weekday) //день недели
//
//        formatter.timeZone = TimeZone(abbreviation: "UTC")
//        formatter.dateFormat = "yyyy/MM/dd HH:mm"
//
//        guard let dateStart = formatter.date(from: "\(year)/\(month)/\(day) 00:00") else { return } //сегоднящний день
//
//        let dateEnd: Date = {
//            let components = DateComponents(day: 1, second: -1) //мы хотим взять день и сделать минус 1 сек, даные будут получены до 23:59:59
//
//            return Calendar.current.date(byAdding: components, to: dateStart) ?? Date()
//        }()
        
        
                                        //ВСЕ ЧТО НАПИСАНО ВЫШЕ ВЫНЕСЕНО В ЭКСТНШН DATE
        
        let dateTimeZone = date.localDate()
        let weekday = dateTimeZone.getWeekDayNumber()
        let dateStart = dateTimeZone.startEndDate().0 // так как метод startEndDate возвращает тюпл, то обращаемся через 0, 1
        let dateEnd = dateTimeZone.startEndDate().1
        //cоздаем предикаты - условия, по которым получают данные( по дате и по дню недели в данном случае)
        //если наш день недели равен викдей и свитч репитов = тру
        let predicateRepeat = NSPredicate(format: "workoutNumberOfDay = \(weekday) AND workoutRepeats = true")
        let predicateUnrepeat = NSPredicate(format: "workoutRepeats = false AND workoutDate BETWEEN %@", [dateStart, dateEnd]) //если ворkаутДата МЕЖДУ датой начал и датой конца
        
        //создадим компаунд - исползуем оба предиката
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeat])
        
        workoutArray = localRealm.objects(WorkoutModel.self).filter(compound).sorted(byKeyPath: "workoutName")
        
        tableView.reloadData()
    }
    
    
    
    //из-за особенностей жиз цикла прописываем отделльный меотд для закругления
    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2 // делаем круг
    }
    
    //для того, чтобы после сохранения в БД наша таблица обновлялась
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDelegates()
        getWorkouts(date: Date()) //cегодншная дата
        //не забыть зарегистрировать ячейку!!!!
        tableView.register(WorkoutTableViewCell.self, forCellReuseIdentifier: idWorkoutTableViewCell)
       
          
    }
      
}

//MARK: - StartWorkoutProtocol

extension MainViewController: StartWorkoutProtocol {
    
    func startButtonTapped(model: WorkoutModel) {
        
        //так как у нас два варианты( либо reps либо timer, то зададим условия)
        if model.workoutTimer == 0 {
            let startVC = StartWorkoutViewController()
            startVC.modalPresentationStyle = .fullScreen
            startVC.workoutModel = model
            present(startVC, animated: true, completion: nil)
        } else {
            print("timer")
            let timerVC = TimerWorkoutViewController()
            timerVC.modalPresentationStyle = .fullScreen
            timerVC.workoutModel = model
            present(timerVC, animated: true, completion: nil)
        }
        
    }
}

//MARK: - Set Delegates

extension MainViewController {
    private func setDelegates() {
        tableView.dataSource = self
        tableView.delegate  = self
        calendarView.cellCollectionViewDelegate = self
    }
}

//MARK: - Setup Views

extension MainViewController {
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
}

extension MainViewController: SelectCollectionViewItemProtocol {
    func selectIem(date: Date) {
        getWorkouts(date: date)
    }
    
    
}

//MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        workoutArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idWorkoutTableViewCell", for: indexPath) as! WorkoutTableViewCell
        
        let model = workoutArray[indexPath.row] //по каждой яейке получаем запись из массива
        
        cell.cellConfigure(model: model)
         
        //после того как прописаи протокол, назначаем делегата...так как у нас ячейка, то назначаем ячейку
        cell.cellStartWorkoutDelegate = self
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //устанавливаем выоту ячейки
        return 100
        
    }
    
    //чтобы удалить ячейки по свайпу
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "") { _, _, _ in
            let deleteModel  = self.workoutArray[indexPath.row]
            RealmManager.shared.deleteWorkoutModel(model: deleteModel)
            tableView.reloadData()
        }
        action.backgroundColor = .specialbackground
        action.image = UIImage(named: "delete")
        
        return UISwipeActionsConfiguration(actions: [action])
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
