//
//  CalendarView.swift
//  Gym
//
//  Created by Андрей Яфаркин on 05.06.2022.
//

import UIKit

class CalendarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // все что писали во вьюдидлоад, можно пиать здесь
        setupViews()
        setConstraints()
        setDelegates()
        
        //3- регистириуем ячейку
        collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: idCalendarCell)
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
    
    //1- cоздаем коллекшн вью
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .none
        
        return collectionView
        
    }()
    
    //2 - создаем айди ячейки
    private let idCalendarCell = "idCalendarCell"
    
   
    
    private func setupViews() {
        
        backgroundColor = .speciakGreen
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        weekArray()
    }
    
   
    //7
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func weekArray() -> [[String]]{
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.dateFormat = "EEEEEE"
      
        var weekArray: [[String]] = [[],[]]
        let calendar = Calendar.current
        let today = Date()
        
        for i in -6...0 {
            let date = calendar.date(byAdding: .weekday, value: i, to: today)
            guard let date = date else { return weekArray }
    
            let components = calendar.dateComponents([.day], from: date)
   
            weekArray[1].append(String(components.day ?? 0))
            let weekDay = dateFormatter.string(from: date)
            weekArray[0].append(String(weekDay))
 

        }
        
        return weekArray
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
//4
extension CalendarView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idCalendarCell", for: indexPath) as! CalendarCollectionViewCell
        cell.cellConfigure(weekArray: weekArray(), indexPath: indexPath)
        
        if indexPath.item == 6 {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .right)
        }
        
        cell.backgroundColor = .speciakGreen
        
        return cell
    }
     
}

//MARK: - Collection Delegate

//5 - подписываем на делегаты
extension CalendarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collection View tapped")
    }
}


//6
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
