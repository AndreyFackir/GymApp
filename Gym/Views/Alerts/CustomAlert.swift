//
//  CustomAlert.swift
//  Gym
//
//  Created by Андрей Яфаркин on 30.06.2022.
//

import UIKit

class CustomAlert {
    
    private let backgroundView: UIView = {
        let element = UIView()
       
        element.backgroundColor = .black
        element.alpha = 0
        return element
    }()
    
    private let alertView: UIView = {
        let element = UIView()
       //тамик не ставим потому что вс фрймами будем делать
        element.backgroundColor = .specialbackground
        element.layer.cornerRadius = 20
        return element
    }()
    
    private var mainView: UIView?
    
    func alertCustom(viewController: UIViewController, completion: @escaping (String, String) -> Void){
        //из какого ВС бдуем вызывать - первый параметр, в комплишн передавать будет репсы и сеты
        
        guard let parentView = viewController.view else { return } //будет вьюха по размеру такая же как и вью у вьюконтроллера
        mainView  = parentView
        
        backgroundView.frame = parentView.frame
        parentView.addSubview(backgroundView)
        
        alertView.frame = CGRect(x: 40,
                                 y: -420,
                                 width: parentView.frame.width - 80,
                                 height: 420)
        
        parentView.addSubview(alertView)
        
        let sportsmnaImageView = UIImageView(frame: CGRect(x: (alertView.frame.width - alertView.frame.height * 0.4) / 2,
                                                           y: 30,
                                                           width: alertView.frame.height * 0.4,
                                                           height: alertView.frame.height * 0.4))
        sportsmnaImageView.image = UIImage(named: "Girl")
        sportsmnaImageView.contentMode = .scaleAspectFit
        alertView.addSubview(sportsmnaImageView)
        
        let editingLabel = UILabel(frame: CGRect(x: 10,
                                                 y: alertView.frame.height * 0.4 + 50,
                                                 width: alertView.frame.width - 20,
                                                 height: 25))
        editingLabel.text = "Editing"
        editingLabel.font = .robotoMedium24
        editingLabel.textAlignment = .center
        alertView.addSubview(editingLabel)
        
        let setLabel = UILabel(text: "Sets")
        setLabel.translatesAutoresizingMaskIntoConstraints = true //так как делаем фреймами
        setLabel.frame = CGRect(x: 30,
                                y: editingLabel.frame.maxY + 10, //почти тож что и боттом энкор
                                width: alertView.frame.width - 60,
                                height: 20)
        alertView.addSubview(setLabel)
        
        let setsTextField = UITextField(frame: CGRect(x: 20, y: setLabel.frame.maxY,
                                                      width: alertView.frame.width - 40,
                                                      height: 30))
        setsTextField.backgroundColor = .specialBrown
        setsTextField.borderStyle = .none
        setsTextField.layer.cornerRadius = 10
        setsTextField.textColor = .specialGray
        setsTextField.font = .robotoBold20
        setsTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: setsTextField.frame.height))
        setsTextField.leftViewMode = .always
        setsTextField.clearButtonMode = .always
        setsTextField.returnKeyType = .done
        setsTextField.keyboardType = .numberPad
        
        alertView.addSubview(setsTextField)
        
        let repsLabel = UILabel(text: "Sets")
        repsLabel.translatesAutoresizingMaskIntoConstraints = true //так как делаем фреймами
        repsLabel.frame = CGRect(x: 30,
                                y: setsTextField.frame.maxY + 3, //почти тож что и боттом энкор
                                width: alertView.frame.width - 60,
                                height: 20)
        alertView.addSubview(repsLabel)
        
        let repsTextField = UITextField(frame: CGRect(x: 20,
                                                      y: repsLabel.frame.maxY,
                                                      width: alertView.frame.width - 40,
                                                      height: 30))
        repsTextField.backgroundColor = .specialBrown
        repsTextField.borderStyle = .none
        repsTextField.layer.cornerRadius = 10
        repsTextField.textColor = .specialGray
        repsTextField.font = .robotoBold20
        repsTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: repsTextField.frame.height))
        repsTextField.leftViewMode = .always
        repsTextField.clearButtonMode = .always
        repsTextField.returnKeyType = .done
        repsTextField.keyboardType = .numberPad
        
        alertView.addSubview(repsTextField)
        
        let okButton = UIButton(frame: CGRect(x: 50,
                                              y: repsTextField.frame.maxY + 15,
                                              width: alertView.frame.width - 100,
                                              height: 35))
        okButton.backgroundColor = .speciakGreen
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.textColor = .white
        okButton.titleLabel?.font = .robotoMedium18
        okButton.layer.cornerRadius = 10
        okButton.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        alertView.addSubview(okButton)
        
       
        
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundView.alpha = 0.8
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.3) {
                    self.alertView.center = parentView.center
                }
            }
        }

    }
    @objc  private func okButtonPressed() {
        print("okButtonPressed")
        guard let targetView = mainView else { return }
        
        //создаем анимацию для закрытия( улетает вниз)
        
        UIView.animate(withDuration: 0.3) {
            self.alertView.frame = CGRect(x: 40,
                                          y: targetView.frame.height,
                                          width: targetView.frame.width - 80,
                                          height: 420)
        } completion: { done in // когда первая анимация заказнчивается( уезжает вьюшкак), запускается другая( бэкграунда альфа)
            if done {
                UIView.animate(withDuration: 0.3) {
                    self.backgroundView.alpha = 0
                } completion: { done in
                    if done {
                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                    }
                }

            }
        }

    }
}
