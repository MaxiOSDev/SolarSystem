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

// Unused singlton. Used it as an approach before, but things got messy and buggy.
class ImageData {
    static let shared = ImageData()
    var imageURL: URL?
    var imageState: ImageState?
    var image: UIImage?
    func add(with url: URL, image: UIImage, imageState: ImageState){
        self.imageURL = url
        self.image = image
        self.imageState = imageState
    }

}
