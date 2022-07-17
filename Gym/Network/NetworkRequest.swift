//
//  NetworkRequest.swift
//  Gym
//
//  Created by Андрей Яфаркин on 14.07.2022.
//

import Foundation

class NetworkRequest {
    
    static let shared = NetworkRequest()
    private init() {}
    
    //cоздаем запрос
    func requestData(completion: @escaping (Result<Data, Error>) -> Void) { //у Result есть 2 состояния - failure и success
        
        let key = "02b7b88c8bcde38b5ee9f95ce7efe0b2"
        
        let latitude = 59.933880
        let longitude = 30.337239
        
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(key)&units=metric"
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, repsonce, error in
                //все данные с пи должны получать в АСИНХРОННОМ РЕЖИМЕ
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        .resume()
    
    }
}
