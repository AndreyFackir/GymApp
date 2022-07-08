//
//  UserModel.swift
//  Gym
//
//  Created by Андрей Яфаркин on 08.07.2022.
//

import Foundation
import  RealmSwift

class UserModel: Object {
    @Persisted var userFirstName: String = "Unknown"
    @Persisted var userLastName: String = "Unknown"
    @Persisted var userHeight: Int = 0
    @Persisted var userWeight: Int = 0
    @Persisted var userTarget: Int = 0
    @Persisted var userImage: Data?
}
