//
//  EditingProfileViewController.swift
//  Gym
//
//  Created by Андрей Яфаркин on 04.07.2022.
//

import UIKit

class EditingProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    private let editingProfileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "EDITING PROFILE"
        label.textColor = .specialBlack
        label.font = .robotoMedium24
        return label
    }()
    
}

//MARK: -  setupViews
extension EditingProfileViewController {
    private func setupViews() {
        view.backgroundColor = .specialbackground
        view.addSubview(editingProfileLabel)
    }
}

//MARK: - SetConstraints
extension EditingProfileViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            editingProfileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            editingProfileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
