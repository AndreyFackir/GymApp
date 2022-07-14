//
//  OnboardingViewController.swift
//  Gym
//
//  Created by Андрей Яфаркин on 13.07.2022.
//

import UIKit

struct OnboardingModel {
    let topLabel: String
    let bottomLabel: String
    let image: UIImage
}

class OnboardingViewController: UIViewController{
    
    private let idOnboardingCell = "idOnboardingCell"
    private var onboardingArray = [OnboardingModel]()
    private var collectionItem = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDelegates()
    }
    
    private let nextButton: UIButton = {
        let element = UIButton(type: .system)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitle("NEXT", for: .normal)
        element.titleLabel?.font = .robotoBold20
        element.layer.cornerRadius = 25
        element.tintColor = .specialGreen
        element.backgroundColor = .white
        element.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return element
    }()
    
    @objc private func nextButtonTapped() {
        
        if collectionItem == 1 {// когда равен одному и нажимаем кнопку еще раз, то меняется тайтл кнопки
            nextButton.setTitle("START", for: .normal)
        }
        
        if collectionItem == 2 {
            saveUserDefaults()
        } else {
            collectionItem += 1
            let index: IndexPath = [0, collectionItem]
            onboardoinCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = collectionItem
        }
    }
    
    private let pageControl: UIPageControl = {
        let element = UIPageControl()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.numberOfPages = 3
        element.isEnabled = false
        element.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        return element
    }()
    
    private let onboardoinCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.isScrollEnabled = false
        collection.backgroundColor = .none
        return collection
    }()
    
    private func saveUserDefaults() { // для храннеия пользовательских настроек
        let userDafaults = UserDefaults.standard // создаем экземпляр
        userDafaults.set(true, forKey: "OnboardingWasViewed") // устанавливаем значение
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - setupViews
extension OnboardingViewController {
    private func setupViews() {
        view.backgroundColor = .specialGreen
        view.addSubview(nextButton)
        view.addSubview(pageControl)
        view.addSubview(onboardoinCollection)
        onboardoinCollection.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: idOnboardingCell)
        
        guard let imageFirst = UIImage(named: "onboardingFirst"),
              let imageSecond = UIImage(named: "onboardingSecond"),
              let imageThird = UIImage(named: "onboardingThird") else { return }
        
        let firstScreen = OnboardingModel(topLabel: "Have a good health",
                                          bottomLabel: "Being healthy is all, no health is nothing. So why dont we start workout", image: imageFirst)
        
        let secondScreen = OnboardingModel(topLabel: "Be Stronger",
                                           bottomLabel: "Take 30 minutes every dayor more to exersice",
                                           image: imageSecond)
        
        let thirdScreen = OnboardingModel(topLabel: "Have a nice body",
                                          bottomLabel: "Bad body shape, poor soul",
                                          image: imageThird)
        onboardingArray = [firstScreen, secondScreen, thirdScreen]
        
    }
}

//MARK: - setDelegates
extension OnboardingViewController {
    private func setDelegates() {
        onboardoinCollection.delegate = self
        onboardoinCollection.dataSource = self
    }
}

//MARK: - UICollectionViewDataSource
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idOnboardingCell, for: indexPath) as! OnboardingCollectionViewCell
        let model = onboardingArray[indexPath.row]
        cell.cellConfigure(model: model)
        return cell
    }
    
}
//MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
}

//MARK: - setConstraints
extension OnboardingViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            onboardoinCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            onboardoinCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            onboardoinCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            onboardoinCollection.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20)
        ])
    }
}
