//
//  RoverCellViewModel.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/3/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import UIKit

struct RoverCellViewModel {
    var image: UIImage
    var id: String
    
}

extension RoverCellViewModel {
    init(roverData: Photo?) {
        self.image = roverData?.imageState == .downloaded ? (roverData?.image!)! : #imageLiteral(resourceName: "imagePlaceholder")
        self.id = "\(roverData!.id)"
    }
}
