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
    
}
