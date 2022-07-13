//
//  OnboardingViewController.swift
//  Gym
//
//  Created by Андрей Яфаркин on 13.07.2022.
//

import UIKit

class OnboardingViewController: UIViewController{
    
   private let idOnboardingCell = "idOnboardingCell"
    
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
        print("nextButtonTapped")
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


}

//MARK: - setupViews
extension OnboardingViewController {
    private func setupViews() {
        view.backgroundColor = .specialGreen
        view.addSubview(nextButton)
        view.addSubview(pageControl)
        view.addSubview(onboardoinCollection)
        onboardoinCollection.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: idOnboardingCell)
        
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
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idOnboardingCell, for: indexPath) as! OnboardingCollectionViewCell
       
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
            onboardoinCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            onboardoinCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            onboardoinCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            onboardoinCollection.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20)
        ])
    }
}
