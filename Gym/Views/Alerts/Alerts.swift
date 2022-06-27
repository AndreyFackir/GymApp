//
//  Alerts.swift
//  Gym
//
//  Created by Андрей Яфаркин on 23.06.2022.
//

import UIKit

extension UIViewController {
    
    func alertOK (title: String, message: String?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(ok)
        
        present(alertController, animated: true, completion: nil)
    }
    
     
}
