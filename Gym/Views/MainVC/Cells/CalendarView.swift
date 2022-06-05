//
//  CalendarView.swift
//  Gym
//
//  Created by Андрей Яфаркин on 05.06.2022.
//

import UIKit

class CalendarView: UIView {
   
    
    //cоздаем коллекшн вью
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .red
        
        return collectionView
        
    }()
    
    private let idCalendarCell = "idCalendarCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // все что писали во вьюдидлоад, можно пиать здесь
        setupViews()
        setConstraints()
        setDelegates()
        collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: idCalendarCell)
      
    }
    
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        backgroundColor = .speciakGreen
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        
    }
    
   
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

//MARK: - Set Constraints
extension CalendarView {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
        
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 105),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        
        ])
        
    }
}

//MARK: - Collection DataSource
extension CalendarView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idCalendarCell", for: indexPath) as! CalendarCollectionViewCell
        cell.backgroundColor = .specialYellow
        return cell
    }
     
}

//MARK: - Collection Delegate

extension CalendarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collection View tapped")
    }
}


extension CalendarView: UICollectionViewDelegateFlowLayout {
    //устанавливаем размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 39, height: collectionView.frame.height)
    }
//устанавливаем расстояние между ячейками
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        3
    }
}
