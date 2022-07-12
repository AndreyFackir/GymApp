//
//  StatisticViewController.swift
//  Gym
//
//  Created by Андрей Яфаркин on 20.06.2022.
//

import UIKit
import RealmSwift

struct ResultWorkout {
    let name: String
    let result: Int
    let imageData: Data?
}


class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userArray = localRealm.objects(UserModel.self)
        setupViews()
        setConstraints()
        setDelegates()
        exersizeCollectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: profileCollectionViewCell)
        getWorkoutResults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupParameters()
        exersizeCollectionView.reloadData()
    }
    
   
    
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PROFILE"
        label.textColor = .specialBlack
        label.font = .robotoMedium24
        return label
    }()
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(red: 194/255, green: 194/255, blue: 194/255, alpha: 1.0)
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit 
        return imageView
    }()
    
    override func viewDidLayoutSubviews() {
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.frame.width / 2
    }
    
    private let nameView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .specialGreen
        element.layer.cornerRadius = 10
        return element
    }()
    
    private let nameLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Your Name"
        element.font = .robotoMedium24
        element.textColor = .white
        return element
    }()
    
    private let heighLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Height: _"
        element.textColor = .specialBlack
        element.font = .robotoMedium14
        return element
    }()
    
    private let weightLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Weight: _"
        element.textColor = .specialBlack
        element.font = .robotoMedium14
        return element
    }()
    
    private lazy var editingButton: UIButton = {
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "pencil")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 5
        configuration.baseForegroundColor = .specialGreen
        configuration.contentInsets = .zero
        
        var text = AttributeContainer()
        text.font = .robotoMedium14
        configuration.attributedTitle = AttributedString("Editing", attributes: text)
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction() {_ in
            print("editingButtonTapped")
            let editingVC = EditingProfileViewController()
            editingVC.modalPresentationStyle = .fullScreen
            self.present(editingVC, animated: true, completion: nil)
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var heightWeightStack = UIStackView()
    
    private let exersizeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .none
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
      
        return collectionView
    }()
    
    private let profileCollectionViewCell = "profileCollectionViewCell"
    
    private let targetLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Target: 0 workouts"
        element.textColor = .specialBlack
        element.font = .robotoBold16
        return element
    }()
    
    private let startProgressLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textColor = .specialBlack
        element.text = "0"
        element.font = .robotoMedium18
        return element
    }()
    
    private let endProgressLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textColor = .specialBlack
        element.text = "0"
        element.font = .robotoMedium18
        return element
    }()
    
    private var starEndStackView = UIStackView()
    
    private let progressBar: UIProgressView = {
        let element = UIProgressView(progressViewStyle: .bar)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.progressTintColor = .specialGreen
        element.layer.cornerRadius = 10
        element.backgroundColor = .specialLine
        element.clipsToBounds = true
        element.setProgress(0, animated: false)
        
        //corner radius у активной полоски
        element.layer.sublayers?[1].cornerRadius = 10
        element.subviews[1].clipsToBounds = true
        return element
    }()
    
    private let localRealm = try! Realm()
    private var workoutArray: Results<WorkoutModel>!
    private var userArray: Results<UserModel>!
    
    
    private var resultWorkout = [ResultWorkout]()
    
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
    
    private func getWorkoutResults() {
        let nameArray = getWorkoutsName() //все имена упражнений уникальные
        
        for name in nameArray {
            let predicateName = NSPredicate(format: "workoutName = '\(name)'") //выдираем все упражнения
            workoutArray = localRealm.objects(WorkoutModel.self).filter(predicateName).sorted(byKeyPath: "workoutName") //сортируем по имени упражнения
            
            var results  = 0
            var image: Data?
            workoutArray.forEach { model in
                results += model.workoutReps
                image = model.workoutImage
            }
            let resultModel = ResultWorkout(name: name, result: results, imageData: image)
            resultWorkout.append(resultModel)
        }
        
    }
    
    private func setupParameters() {
        if userArray.count != 0 {
            nameLabel.text = userArray[0].userFirstName + " " + userArray[0].userLastName
            heighLabel.text = "Height: \(userArray[0].userHeight)"
            weightLabel.text = "Weight: \(userArray[0].userWeight)"
            targetLabel.text = "Target: \(userArray[0].userTarget) workouts"
            endProgressLabel.text = "\(userArray[0].userTarget)"
            
            guard let data = userArray[0].userImage else { return }
            guard let image = UIImage(data: data) else { return }
            profilePhotoImageView.image = image
        }
    }
    
}


//MARK: - UICollectionViewDataSource

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        resultWorkout.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        
        let model = resultWorkout[indexPath.row]
        cell.cellConfigure(model: model)
        
        cell.backgroundColor = indexPath.row % 4 == 0 || indexPath.row % 4 == 3 ? .specialGreen : .specialYellow
        
        return cell
    }
    
    
}

//MARK: - UICollectionViewDelegate
extension ProfileViewController: UICollectionViewDelegate {
    
    
    
}

//MARK: - UICollectionViewFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: collectionView.frame.width / 2.07, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       5
    }
    
   
   
    
}

extension ProfileViewController {
    private func setDelegates() {
        exersizeCollectionView.delegate = self
        exersizeCollectionView.dataSource = self
    }
}


//MARK: - Setup Views
extension ProfileViewController {
    private func setupViews() {
        view.backgroundColor = .specialbackground
        view.addSubview(profileLabel)
        view.addSubview(nameView)
        view.addSubview(profilePhotoImageView)
        nameView.addSubview(nameLabel)
        view.addSubview(heighLabel)
        heightWeightStack = UIStackView(arrangeSubviews: [heighLabel, weightLabel], axis: .horizontal, spacing: 10)
        view.addSubview(heightWeightStack)
        view.addSubview(editingButton)
        view.addSubview(exersizeCollectionView)
        view.addSubview(targetLabel)
        view.addSubview(progressBar)
        starEndStackView = UIStackView(arrangeSubviews: [startProgressLabel, endProgressLabel], axis: .horizontal, spacing: 10)
        view.addSubview(starEndStackView)
       
    }
}

//MARK: - Set Constrains
extension ProfileViewController {
    private func setConstraints() {
       
        
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            profilePhotoImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 10),
            profilePhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            profilePhotoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 60),
            nameView.heightAnchor.constraint(equalToConstant: 100),
            nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: nameView.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: nameView.bottomAnchor, constant: -15)
        ])
        
        
        NSLayoutConstraint.activate([
            heightWeightStack.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 10),
            heightWeightStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            editingButton.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 10),
            editingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            exersizeCollectionView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 50),
            exersizeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exersizeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            exersizeCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
            exersizeCollectionView.heightAnchor.constraint(equalToConstant: 250)
        ])
       
        NSLayoutConstraint.activate([
            targetLabel.topAnchor.constraint(equalTo: exersizeCollectionView.bottomAnchor, constant: 25),
            targetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            starEndStackView.topAnchor.constraint(equalTo: targetLabel.bottomAnchor, constant: 25),
            starEndStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            starEndStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: starEndStackView.bottomAnchor, constant: 5),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            progressBar.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
