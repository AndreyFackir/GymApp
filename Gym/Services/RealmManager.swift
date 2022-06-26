//
//  RealmManager.swift
//  Gym
//
//  Created by Андрей Яфаркин on 23.06.2022.
//

import Foundation
import RealmSwift

class RealmManager {
    
    //singleton
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    //сохраняем в БД
    func saveWorkoutModel(model: WorkoutModel) {
        try! localRealm.write{
            localRealm.add(model)
        }
    }
}


