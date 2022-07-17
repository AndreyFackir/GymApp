//
//  NetworkDataFetch.swift
//  Gym
//
//  Created by Андрей Яфаркин on 14.07.2022.
//

import Foundation

class NetworkDataFetch {
    static let shared = NetworkDataFetch()
    private init() {}
    
    //получаем погоду
    func fetchWeather(responce: @escaping (WeatherModel?, Error?) -> Void) {
        NetworkRequest.shared.requestData { result in
            switch result {
                
            case .success(let data):
                do {
                    let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                    responce(weather,nil)
                }
                catch let jsonError{
                    print("Failed to decode", jsonError)
                }
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
}
