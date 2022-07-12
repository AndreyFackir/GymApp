//
//  Notifications.swift
//  Gym
//
//  Created by Андрей Яфаркин on 12.07.2022.
//

import Foundation
import UserNotifications

//создаем уведомления
class Notifications: NSObject {
    
    let notoficationCenter = UNUserNotificationCenter.current()
    
    //прежде чем мы сможем получать уведомления нам нужен доступ
    func reauestAutorization() {
        notoficationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted else { return }
            
        }
    }
    
    //проверяем все ли настройки об уведомлениях включены
    
    func getNotificationsSettings() {
        notoficationCenter.getNotificationSettings { settings in
            print(settings)
        }
    }
}
