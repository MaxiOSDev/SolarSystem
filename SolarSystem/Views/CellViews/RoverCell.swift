//
//  RoverCell.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/3/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit

class RoverCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageID: UILabel!
    
    
    func configure(with viewModel: RoverCellViewModel) {
        imageView.image = viewModel.image
        imageID.text = viewModel.id
    }
}
