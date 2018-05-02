//
//  PendingOperations.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/2/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation

// Taught from iTunesClient
class PendingOperations {
    var downloadsInProgress = [IndexPath: Operation]()
    
    let downloadQueue = OperationQueue()
}
