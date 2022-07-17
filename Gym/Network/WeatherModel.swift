//
//  WeatherModel.swift
//  Gym
//
//  Created by Андрей Яфаркин on 14.07.2022.
//

import Foundation
import UIKit

struct WeatherModel: Codable {
//    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Codable {
    let temp: Double
    
}

struct Weather: Codable {
   
    let id: Int
    let icon: String?
    
    var iconLocal: String {
        switch icon {
        case "01d" : return "Ясно"
        case "02d" : return "Небольшая облачность"
        case "03d" : return "Переменная облачность"
        case "04d" : return "Облачно"
        case "09d" : return "небольшой дождь"
        case "10d" : return "Дождь"
        case "11d" : return "Дождь с грозой"
        case "13d" : return "Снег"
        case "50d" : return "Туман"
        default: return "No data"
        }
    }
    
    var description: String {
        switch icon {
        case "01d" : return "Ясно"
        case "02d" : return "Небольшая облачность"
        case "03d" : return "Сиди дома, все равно облачно"
        case "04d" : return "Облачно"
        case "09d" : return "небольшой дождь"
        case "10d" : return "Дождь"
        case "11d" : return "Дождь с грозой"
        case "13d" : return "Снег"
        case "50d" : return "Туман"
        default: return "No data"
        }
    }
    
    var iconImage: String {
        switch icon {
        case "01d": return "cloud.bolt.rain.fill"
        case "02d": return "cloud.drizzle.fill"
        case "03d": return "cloud.rain"
        case "04d": return "cloud.snow"
        case "09d": return "cloud.fog"
        case "10d": return "sun.max"
        case "11d": return "cloud.bolt"
        case "13d": return "cloud.bolt"
        case "50d": return "cloud.bolt"
        default: return "No data"
        }
    }
    
    
}




