//
//  ProfileCollectionViewCell.swift
//  Gym
//
//  Created by Андрей Яфаркин on 03.07.2022.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

//MARK: - Setup Views
extension ProfileCollectionViewCell {
    private func setupViews() {
        backgroundColor = .specialGreen
        layer.cornerRadius = 20
    }
}

extension ProfileCollectionViewCell {
    private func setConstraints() {
        
    }
}
