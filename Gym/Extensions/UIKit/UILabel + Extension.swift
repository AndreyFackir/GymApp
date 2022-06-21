//
//  UILabel + Extension.swift
//  Gym
//
//  Created by Андрей Яфаркин on 20.06.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String = "") {
        self.init()
        
        self.text = text
        self.font = .robotoMedium12()
        self.textColor = .specilaLightBrown
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
