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
    
    func saveUserModel(model: UserModel) {
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
    
    func updateUserModel(model: UserModel) {
        
        let user = localRealm.objects(UserModel.self)
        try! localRealm.write{
            user[0].userFirstName = model.userFirstName
            user[0].userLastName = model.userLastName
            user[0].userHeight = model.userHeight
            user[0].userWeight = model.userWeight
            user[0].userImage = model.userImage
            user[0].userTarget = model.userTarget
            
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
    
    func updateSetsTimerWorkoutModel(model: WorkoutModel, sets: Int, timer: Int) {
        try! localRealm.write{
            model.workoutSets = sets
            model.workoutTimer = timer
            
        }
    }
}


