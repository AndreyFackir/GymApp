//
//  ViewController.swift
//  Gym
//
//  Created by Андрей Яфаркин on 02.06.2022.
//

import UIKit

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
    
    private let calendarView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .speciakGreen
        view.layer.cornerRadius = 10
        
        return view
        
        
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
    
    //из-за особенностей жиз цикла прописываем отделльный меотд для закругления
    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2 // делаем круг
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        
        
        
    }
    
    private func setupViews() {
        view.backgroundColor = .specialbackground
        //2 - добавили на экран элемент
        view.addSubview(calendarView)
        view.addSubview(userPhotoImageView)
        view.addSubview(userNameLabel)
    }
    
    
}

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
    }
}
