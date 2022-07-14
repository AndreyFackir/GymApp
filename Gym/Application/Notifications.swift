//
//  Notifications.swift
//  Gym
//
//  Created by Андрей Яфаркин on 12.07.2022.
//

import Foundation
import UserNotifications
import UIKit

//создаем уведомления
class Notifications: NSObject {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    //прежде чем мы сможем получать уведомления нам нужен доступ
    func requestAutorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted else { return }
            
            //после п роверки разрешения на уведомления вызываем метод
            self.getNotificationsSettings()
        }
    }
    
    //проверяем все ли настройки об уведомлениях включены
    func getNotificationsSettings() {
        notificationCenter.getNotificationSettings { settings in
            print(settings)
        }
    }
    
    //после получения доступа на уведомления создаем сами уведомления
    func scheduleNotification(date: Date, id: String) {
        
        // у каждого уведомления есть контент(заголовк, тело, звук и тд)
        let content = UNMutableNotificationContent() //можно будет менять потому что Mutable
        content.title = "Workout"
        content.body = "Today you have a training"
        content.interruptionLevel = UNNotificationInterruptionLevel.timeSensitive
        content.sound = .default
        content.badge = 1
        
    //теперь создадим распсиание на срабатывание контента
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        var triggerDate = calendar.dateComponents([.year, .month, .day], from: date)//дата из входных параметров
        print("this is a triggerdate \(triggerDate)")
        triggerDate.hour = 20
        triggerDate.minute = 25
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        // создаем реквест
        let request  = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        notificationCenter.add(request) { error in
            print("Error \(error?.localizedDescription ?? "error")")
        }
    
        
    }
}

//создадим экстешнш
extension Notifications: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound ]) //хотим чтобы поялялся алерт и звук при уведомлении
    }
    
    //отвечает за нажатие на уведлмение и чтото должно произойти
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        UIApplication.shared.applicationIconBadgeNumber = 0 //убираем значок с количеством уведомлений
        notificationCenter.removeAllDeliveredNotifications()//после доставки удаляем все уведомления
    }
}
