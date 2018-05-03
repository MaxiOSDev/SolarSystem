//
//  ImageData.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/1/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class ImageData {
    static let shared = ImageData()
    var imageURL: URL?
    var imageState: ImageState?
    var image: UIImage?
    var videoURL: URL?
    
    func add(with url: URL, image: UIImage, imageState: ImageState){
        self.imageURL = url
        self.image = image
        self.imageState = imageState
    }
    
    func addVideo(with url: URL) {
        self.videoURL = url
    }
}

