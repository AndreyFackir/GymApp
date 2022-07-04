//
//  MainTabBarController.swift
//  Gym
//
//  Created by Андрей Яфаркин on 20.06.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupItems()
        
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .specialTabBar
        tabBar.tintColor = .specialDarkGreen
        //color of unselected items
        tabBar.unselectedItemTintColor = .specialGray
        //обводка
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.specilaLightBrown.cgColor
        tabBar.isTranslucent = true
        
    }
    
    private func setupItems() {
        
        //создадим у айтемов ссылки на вьюшки 
        let mainVC = MainViewController()
        let statisticVC = StatisticViewController()
        let profile = ProfileViewController()
        
        setViewControllers([mainVC, statisticVC, profile], animated: true)
        
        guard let items = tabBar.items else { return }
        
        items[0].title = "Main"
        items[1].title = "Statistic"
        items[2].title = "Profile"
       
        
        items[0].image = UIImage(named: "Document Justify Center 2")
        items[1].image = UIImage(named: "Filter 5")
        items[2].image = UIImage(named: "Profile 1")
        
        
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(name: "Roboto-Bold", size: 12) as Any], for: .normal)
    }
    
}
