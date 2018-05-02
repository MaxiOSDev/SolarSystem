//
//  Result.swift
//  SolarSystem
//
//  Created by Max Ramirez on 4/30/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}





