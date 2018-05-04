//
//  NASAEarthImagery.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/4/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation

class EarthImageryData {
    static var sharedInstance = EarthImageryData()
    
    var lat: Double?
    var lon: Double?
    var date: String?
    var url: String?
    var name: String?
    var address: String?
}

struct NASAEarthImagery: Codable {
    let date: String
    let id: String
    let resource: Resource
    let serviceVersion: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case id = "id"
        case resource = "resource"
        case serviceVersion = "service_version"
        case url = "url"
    }
}

struct Resource: Codable {
    let dataset: String
    let planet: String
    
    enum CodingKeys: String, CodingKey {
        case dataset = "dataset"
        case planet = "planet"
    }
}
