//
//  WeatherView.swift
//  Gym
//
//  Created by Андрей Яфаркин on 05.06.2022.
//

import UIKit

class WeatherView: UIView {
    
    
    private let weatherImage: UIImageView = {
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Sun")
        return image
        
    }()
    
    private let weatherLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Солнечно"
        label.textColor = .specialBlack
        label.font = .robotoBold20()
        
        return label
    }()
    
    private let descriptionWeather: UILabel = {
        
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.textColor = .specilaLightBrown
        description.text = "Хорошая погодa, чтобы позаниматься на улице"
        description.font = .robotoMedium12()
        description.numberOfLines = 2
        description.adjustsFontSizeToFitWidth = true
        description.minimumScaleFactor = 0.5
        
        return description
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        addShadowOnView()
        addSubview(weatherImage)
        addSubview(weatherLabel)
        addSubview(descriptionWeather)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            weatherImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            weatherImage.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            weatherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weatherLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            descriptionWeather.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionWeather.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 10),
            descriptionWeather.trailingAnchor.constraint(equalTo: weatherImage.leadingAnchor, constant: -20)
        ])
    }
}
