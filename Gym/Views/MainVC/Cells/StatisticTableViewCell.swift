//
//  StatisticTableViewCell.swift
//  Gym
//
//  Created by Андрей Яфаркин on 29.06.2022.
//

import UIKit

class StatisticTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}


//MARK: - setupViews
extension StatisticTableViewCell {
    
    private func setupViews() {
        
        backgroundColor = .clear
        selectionStyle = .none
    }
}

//MARK: - setConstraints
extension StatisticTableViewCell {
    private func setConstraints() {
        
    }
}
