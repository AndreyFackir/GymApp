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
    
    //обновляем статус тренировки( закончена она или нет)
    func updateStatusWorkoutModel(model: WorkoutModel, bool: Bool) {
        try! localRealm.write{
            model.status = bool
            
        }
    }
    
    // удаляем тренировку
    func deleteWorkoutModel(model: WorkoutModel) {
        try! localRealm.write{
            localRealm.delete(model)
        }
    }
    
    //после нажатия на editing button будем обновлять сты и репсы
    func updateSetsRepsWorkoutModel(model: WorkoutModel, sets: Int, reps: Int) {
        try! localRealm.write{
            model.workoutSets = sets
            model.workoutReps = reps
            
        }
    }
}


