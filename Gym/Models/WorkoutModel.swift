//
//  WorkoutModel.swift
//  Gym
//
//  Created by Андрей Яфаркин on 21.06.2022.
//

import Foundation
import RealmSwift

class WorkoutModel: Object {
    //создаем модель исходя из данных для заполнения на вьюшке NEW WORKOUT
    @Persisted var workoutDate: Date //дата
    @Persisted var workoutNumberOfDay: Int = 0 //день недели
    @Persisted var workoutName: String = "Uknown" //имя
    @Persisted var workoutRepeats: Bool = true //свитч повторов для тренировок
    @Persisted var workoutSets: Int = 0
    @Persisted var workoutReps: Int = 0
    @Persisted var workoutTimer: Int = 0
    @Persisted var workoutImage: Data? //здесь будем хранить изображение
    @Persisted var status = false //чтобы понимать закночилось упражнение или нет
}
