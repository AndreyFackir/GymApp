//
//  Dae.swift
//  Gym
//
//  Created by Андрей Яфаркин on 30.06.2022.
//

import Foundation

extension Date {
    
    //метод, преобразующий дату в соответсвтии с тайм зоной в которой находится юзер
    func localDate() -> Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: self) ?? Date()
        return localDate
    }
    
    // если четверг, то возвращаем 4
    func getWeekDayNumber() -> Int {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: self)
        return weekday
    }
    
    //используем дату для предикатов
    //берем дату на данный момент
    //к дате начала прибавляем одни день минус 1 сек
    func startEndDate() -> (Date, Date) {
        
        let formater = DateFormatter()
        formater.dateFormat = "yyyy/MM/dd"
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        let day = calendar.component(.day, from: self)
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        
        let dateStart = formater.date(from: "\(year)/\(month)/\(day)") ?? Date()
        let local = dateStart.localDate()
        let dateEnd: Date = {
            let components = DateComponents(day: 1)
            return calendar.date(byAdding: components, to: local) ?? Date()
        }()
        
        return (local, dateEnd)
        
    }
    
    //показывает дни в календаре
    func offsetDays(days: Int) -> Date {
        let offsetDate = Calendar.current.date(byAdding: .day, value: -days, to: self) ?? Date()
        return offsetDate
    }
    
    func offsetMonth(month: Int) -> Date {
        let offsetMonth = Calendar.current.date(byAdding: . month, value: -month, to: self) ?? Date()
        return offsetMonth
    }
    
    func getWeekArray() -> [[String]] {
        
        //задам формат в котором будут указаны данные
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.dateFormat = "EEEEEE" //2 буквы в назваиии дня недели
        
        //создаем массив который бдуем возвращать
        var weekArray:[[String]] = [[],[]]
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        for index in -6...0 {
            let date = calendar.date(byAdding: .day, value: index, to: self) ?? Date()
           
            let day = calendar.component(.day, from: date) //получаем число дня из календаря
            
            weekArray[1].append("\(day)")
            
            let weekDay = formatter.string(from: date)
            weekArray[0].append(weekDay) //получаем день недели  из календаря
          
        }
        
        return weekArray
    }
    
    func ddMMMyyyFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let date = formatter.string(from: self)
        return date
    }
}
