//
//  UIview + Exxtensions.swift
//  Gym
//
//  Created by Андрей Яфаркин on 05.06.2022.
//

import UIKit

extension UIView {
    
    func addShadowOnView() {
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 1
        
    }
    
}
