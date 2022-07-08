//
//  EditingProfileViewController.swift
//  Gym
//
//  Created by Андрей Яфаркин on 04.07.2022.
//

import UIKit
import RealmSwift

class EditingProfileViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userArray = localRealm.objects(UserModel.self)
        setupViews()
        setConstraints()
        addTaps()
    }
    
    private let editingProfileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "EDITING PROFILE"
        label.textColor = .specialBlack
        label.font = .robotoMedium24
        return label
    }()
    
    private let addPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1)
        imageView.layer.borderWidth = 5
        
        imageView.image = UIImage(systemName: "person.crop.circle.badge.plus")
       
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let addPhotoView: UIView = {
       let view = UIView()
        view.backgroundColor = .specialGreen
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
     
    override func viewDidLayoutSubviews() {
        addPhotoImageView.layer.cornerRadius = addPhotoImageView.frame.height / 2

    }
    
    private let firstNameLabel = UILabel(text: "First name")
    private let firstNameTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.clearButtonMode = .always
        element.backgroundColor = .specialBrown
        element.layer.cornerRadius = 10
        element.font = .robotoBold20
        element.textColor = .specialGray
        element.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: element.frame.height))
        element.leftViewMode = .always
        element.returnKeyType = .done
        return element
    }()
    
    private let secondNameLabel = UILabel(text: "Second name")
    private let secondNameTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.clearButtonMode = .always
        element.backgroundColor = .specialBrown
        element.layer.cornerRadius = 10
        element.font = .robotoBold20
        element.textColor = .specialGray
        element.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: element.frame.height))
        element.leftViewMode = .always
        element.returnKeyType = .done
        return element
    }()
    
    private let weightLabel = UILabel(text: "Weight")
    private let weightTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.clearButtonMode = .always
        element.backgroundColor = .specialBrown
        element.layer.cornerRadius = 10
        element.font = .robotoBold20
        element.textColor = .specialGray
        element.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: element.frame.height))
        element.leftViewMode = .always
        element.returnKeyType = .done
        return element
    }()
    
    private let heightLabel = UILabel(text: "Height")
    private let heightTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.clearButtonMode = .always
        element.backgroundColor = .specialBrown
        element.layer.cornerRadius = 10
        element.font = .robotoBold20
        element.textColor = .specialGray
        element.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: element.frame.height))
        element.leftViewMode = .always
        element.returnKeyType = .done
        return element
    }()
    
    private let targetLabel = UILabel(text: "Target")
    private let targetTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.clearButtonMode = .always
        element.backgroundColor = .specialBrown
        element.layer.cornerRadius = 10
        element.font = .robotoBold20
        element.textColor = .specialGray
        element.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: element.frame.height))
        element.leftViewMode = .always
        element.returnKeyType = .done
        return element
    }()
    
    private lazy var saveButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .large
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .specialGreen
        
        var text = AttributeContainer()
        text.font = .robotoMedium18
        configuration.attributedTitle = AttributedString("SAVE", attributes: text)
        
       
        let button = UIButton(configuration: configuration, primaryAction: UIAction() {_ in
            print("saveButtonTapped")
            
            self.setUserModel()
            
            if self.userArray.count == 0{
                RealmManager.shared.saveUserModel(model: self.userModel)
                self.userModel = UserModel() // всегда обновляем сразу
            } else {
                RealmManager.shared.updateUserModel(model: self.userModel)
                self.userModel = UserModel()
            }
            self.dismiss(animated: true)
        })
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func loadUserInfo() {
        if userArray.count != 0 {
            firstNameTextField.text = userArray[0].userFirstName
            secondNameTextField.text = userArray[0].userLastName
            heightTextField.text = "\(userArray[0].userHeight)"
            weightTextField.text = "\(userArray[0].userWeight)"
            targetTextField.text = "\(userArray[0].userTarget)"
            
            guard let data = userArray[0].userImage else { return }
            guard let image = UIImage(data: data) else { return }
            addPhotoImageView.image = image
            addPhotoImageView.contentMode = .scaleAspectFit
        }
    }
    
    
    private let localRealm = try! Realm()
    private var userArray: Results<UserModel>!
    private var userModel = UserModel()
    
        // добавляем метод выбора фото по тапу на аватарку
    private func addTaps() {
        let tapImageView = UITapGestureRecognizer(target: self, action: #selector(setUserPhoto))
        addPhotoImageView.isUserInteractionEnabled = true
        addPhotoImageView.addGestureRecognizer(tapImageView)
    }
    
    @objc private func setUserPhoto() {
        alertFotoCamera { [weak self] source in
            guard let self = self else { return }
            self.chooseImagePicker(source: source)
        }
    }
    
    
    private func setUserModel() {
        guard let firstName = firstNameTextField.text,
              let lastName = secondNameTextField.text,
              let height = heightTextField.text,
              let weight = weightTextField.text,
              let target = targetTextField.text else { return }
        
        guard let intHeight = Int(height),
                let intWeight = Int(weight),
                  let inttarget = Int(target) else { return }
        
        userModel.userFirstName = firstName
        userModel.userLastName = lastName
        userModel.userHeight = intHeight
        userModel.userWeight = intWeight
        userModel.userTarget = inttarget
        
        
        if addPhotoImageView.image == UIImage(systemName: "person.crop.circle.badge.plus"){
            userModel.userImage = nil
        } else {
            guard let imageData = addPhotoImageView.image?.pngData() else { return }
            userModel.userImage = imageData
        }
    }
    
    
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension EditingProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker( source: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage //получаем имедж из редактируемой картинки
        addPhotoImageView.image = image
        addPhotoImageView.contentMode = .scaleAspectFit
        dismiss(animated: true)
    }
    

}

//MARK: -  setupViews
extension EditingProfileViewController {
    private func setupViews() {
        view.backgroundColor = .specialbackground
        view.addSubview(editingProfileLabel)
        view.addSubview(addPhotoView)
        view.addSubview(addPhotoImageView)
        view.addSubview(firstNameLabel)
        view.addSubview(firstNameTextField)
        view.addSubview(secondNameLabel)
        view.addSubview(secondNameTextField)
        view.addSubview(weightLabel)
        view.addSubview(weightTextField)
        view.addSubview(heightLabel)
        view.addSubview(heightTextField)
        view.addSubview(targetLabel)
        view.addSubview(targetTextField)
        view.addSubview(saveButton)
       
    }
}

//MARK: - SetConstraints
extension EditingProfileViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            editingProfileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            editingProfileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addPhotoImageView.topAnchor.constraint(equalTo: editingProfileLabel.bottomAnchor, constant: 10),
            addPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            addPhotoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            addPhotoView.topAnchor.constraint(equalTo: editingProfileLabel.bottomAnchor, constant: 60),
            addPhotoView.heightAnchor.constraint(equalToConstant: 100),
            addPhotoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addPhotoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            firstNameLabel.topAnchor.constraint(equalTo: addPhotoView.bottomAnchor, constant: 30),
            firstNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            firstNameTextField.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 5),
            firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            secondNameLabel.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 20),
            secondNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            secondNameTextField.topAnchor.constraint(equalTo: secondNameLabel.bottomAnchor, constant: 5),
            secondNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            secondNameTextField.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            weightLabel.topAnchor.constraint(equalTo: secondNameTextField.bottomAnchor, constant: 20),
            weightLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            weightTextField.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 5),
            weightTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            weightTextField.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            heightLabel.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 20),
            heightLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            heightTextField.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 5),
            heightTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            heightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            heightTextField.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            targetLabel.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 20),
            targetLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            targetTextField.topAnchor.constraint(equalTo: targetLabel.bottomAnchor, constant: 5),
            targetTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            targetTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            targetTextField.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: targetTextField.bottomAnchor, constant: 40),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
