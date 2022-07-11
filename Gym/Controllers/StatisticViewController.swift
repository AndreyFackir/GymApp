//
//  StatisticViewController.swift
//  Gym
//
//  Created by Андрей Яфаркин on 20.06.2022.
//

import UIKit
import RealmSwift

//структура для отображения результатов статистики
struct DifferenceWorkout {
    let name: String // название упражнения
    let lastReps: Int
    let firstReps: Int
    // add timer
}


class StatisticViewController: UIViewController {
    
    var differenceArray = [DifferenceWorkout]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDelegates()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableWithParametrs.reloadData()
    }
    
    private let idStatisticTableViewCell = "idStatisticTableViewCell"
    
    private let statisticLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "STATISTICS"
        label.textColor = .specialBlack
        label.font = .robotoMedium24
        return label
    }()
    
    private let segments: UISegmentedControl = {
        let element = UISegmentedControl(items: ["Week", "Month"])
        element.translatesAutoresizingMaskIntoConstraints = false
        element.selectedSegmentTintColor = .specialYellow
        element.selectedSegmentIndex = 0
        element.backgroundColor = .specialGreen
        element.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        element.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.specialGray], for: .selected)
        element.addTarget(self, action: #selector(segmentChanged) , for: .valueChanged)
        return element
    }()
    
    @objc private func segmentChanged() {
        print("segments changed")
        if segments.selectedSegmentIndex == 0{
            differenceArray = [DifferenceWorkout]()
            let dateStart = dateToday.offsetDays(days: 7) //берем сегодняшнюю дату, отсчитываем 7 дней от нее
            getDifferenceModel(dateStart: dateStart)
            tableWithParametrs.reloadData()
        } else {
            differenceArray = [DifferenceWorkout]()
            let dateStart = dateToday.offsetMonth(month: 1)
            getDifferenceModel(dateStart: dateStart)
            tableWithParametrs.reloadData()
        }
        
    }
    
    private let exerciseLabel = UILabel(text: "Exercices")

    private let tableWithParametrs: UITableView = {
        let element = UITableView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .specialbackground
        element.bounces = false
        element.showsVerticalScrollIndicator = false
        return element
    }()
    
    //cоздаем реалм для отображения статистики в таблице
    let localRealm = try! Realm()
    var workoutArray: Results<WorkoutModel>! // cоздаем резуьтаты поиска по модели WorkoutModel
    let dateToday = Date().localDate() //текущая дата
    
    
    private func setStartScreen() {
        getDifferenceModel(dateStart: dateToday.offsetDays(days: 7))
        tableWithParametrs.reloadData()
    }
    
    //хотим получить уникальные записи ( например, жим, присед) массив с именами всех наших упражнений
    private func getWorkoutsName() -> [String] {
        var nameArray = [String]()
        
        //получаем все записи из бд
        workoutArray = localRealm.objects(WorkoutModel.self)
        
        //перебираем каждую модель и если нет в массиве то  закидываем в массив
        for workoutModel in workoutArray {
            if !nameArray.contains(workoutModel.workoutName) {
                nameArray.append(workoutModel.workoutName)
            }
        }
        return nameArray
    }
    
    private func getDifferenceModel(dateStart: Date) {
        
        let dateEnd = Date().localDate()
        let nameArray = getWorkoutsName()
        
        for name in nameArray {
            
          //берем имя упражнения и по имени выбираем между конечной датой и начальной
            let predicateDifference = NSPredicate(format: "workoutName = '\(name)' AND workoutDate BETWEEN %@", [dateStart, dateEnd])
            //берем все значения из бд и фльтруем по нашему предикату, сортируя по дате
            workoutArray = localRealm.objects(WorkoutModel.self).filter(predicateDifference).sorted(byKeyPath: "workoutDate")
            
            guard let last = workoutArray.last?.workoutReps,
                  let first = workoutArray.first?.workoutReps else { return }
            
            let differenceWorkout = DifferenceWorkout(name: name, lastReps: last, firstReps: first)
            differenceArray.append(differenceWorkout)
        }
    }

}


//MARK: - setDelegates
extension StatisticViewController {
    
    private func setDelegates() {
        tableWithParametrs.dataSource = self
        tableWithParametrs.delegate = self
        tableWithParametrs.register(StatisticTableViewCell.self, forCellReuseIdentifier: idStatisticTableViewCell)
    }
}

//MARK: - SetupViews
extension StatisticViewController {
    
    private func setupViews() {
        view.backgroundColor = .specialbackground
        view.addSubview(statisticLabel)
        view.addSubview(segments)
        view.addSubview(exerciseLabel)
        view.addSubview(tableWithParametrs)
    }
}

//MARK: - UITableViewDataSource
extension StatisticViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        differenceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idStatisticTableViewCell, for: indexPath) as! StatisticTableViewCell
        let differenceModel = differenceArray[indexPath.row]
        cell.cellConfigure(differenceWorkout: differenceModel)
        return cell
    }
    
}


//MARK: - UITableViewDelegate

extension StatisticViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
}
//MARK: - SetConstraints
extension StatisticViewController {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            statisticLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            statisticLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            segments.topAnchor.constraint(equalTo: statisticLabel.bottomAnchor, constant: 20),
            segments.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segments.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segments.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            exerciseLabel.topAnchor.constraint(equalTo: segments.bottomAnchor, constant: 20),
            exerciseLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            tableWithParametrs.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor, constant: 0),
            tableWithParametrs.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableWithParametrs.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableWithParametrs.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
       
       
    }
}
