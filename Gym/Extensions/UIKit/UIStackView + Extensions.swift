//
//  UIStackView + Extensions.swift
//  Gym
//
//  Created by Андрей Яфаркин on 05.06.2022.
//

import UIKit

//let stackView = UIStackView()
//stackView.addArrangedSubview(YourView)
//stackView.addArrangedSubview(YorView2)
//stackView.axis = horizontal
//stackView.spacing = 10
//stackView.trtranslatesAutoresizingMaskIntoConstraints = false - констрейнты прописыаем сами

extension UIStackView {
    convenience init(arrangeSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangeSubviews)
        self.axis = axis
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
