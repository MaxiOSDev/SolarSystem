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
    var viewModel = GalleryCellViewModel.shared
    var imageURL: URL?
    var imageState: ImageState = .placeholder
    var nukeManager = Nuke.Manager.shared
    func add(with url: URL){
        self.imageURL = url
    //    self.imageState = state
//
//        nukeManager.loadImage(with: imageURL!) { (image) in
//            self.viewModel.image = image.value!
//            print(self.viewModel.image)
//            print("Image State: \(self.imageState)")
//        }
    }
    
}
