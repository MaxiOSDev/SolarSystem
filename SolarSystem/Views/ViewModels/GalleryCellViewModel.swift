//
//  GalleryCellViewModel.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/2/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import UIKit

struct GalleryCellViewModel {
    var image: UIImage
    let title: String
    
}

extension GalleryCellViewModel {
    init(gallery: GalleryData?) {
        self.image = gallery?.imageState == .downloaded ? (gallery?.image!)! : #imageLiteral(resourceName: "imagePlaceholder")
        self.title = (gallery?.title) ?? ""
    }
}
