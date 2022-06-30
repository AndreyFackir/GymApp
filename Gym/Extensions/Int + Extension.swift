//
//  Int + Extension.swift
//  Gym
//
//  Created by Андрей Яфаркин on 30.06.2022.
//

import Foundation

extension Int {
    //добавляем 0 к секундам
    func setZeroToSeconds() -> String {
        return (Double(self) / 10.0 < 1 ? "0\(self)" : "\(self)")
    }
}
