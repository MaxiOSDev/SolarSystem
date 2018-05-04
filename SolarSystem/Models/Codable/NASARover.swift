//
//  NASARover.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/3/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import UIKit

struct NASARover: Codable {
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case photos = "photos"
    }
}

class Photo: Equatable {
    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id && lhs.sol == rhs.sol && lhs.imgSrc == rhs.imgSrc && lhs.earthDate == rhs.earthDate
    }
    
    var id: Int
    let sol: Int
    let imgSrc: String
    let earthDate: String
    let rover: Rover
    
    var image: UIImage? = ImageData.shared.image
    var imageState: ImageState? = ImageData.shared.imageState
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sol = "sol"
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover = "rover"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        sol = try values.decode(Int.self, forKey: .sol)
        imgSrc = try values.decode(String.self, forKey: .imgSrc)
        earthDate = try values.decode(String.self, forKey: .earthDate)
        rover = try values.decode(Rover.self, forKey: .rover)
    }
    
}

extension Photo: Decodable, Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(sol, forKey: .sol)
        try container.encode(imgSrc, forKey: .imgSrc)
        try container.encode(earthDate, forKey: .earthDate)
        try container.encode(rover, forKey: .rover)
    }
}


struct Rover: Codable {
    let id: Int
    let landingDate: String
    let launchDate: String
    let maxSol: Int
    let maxDate: String
    let totalPhotos: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
    }
}
