//
//  LandingCell.swift
//  SolarSystem
//
//  Created by Max Ramirez on 4/30/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!

    func configure(with viewModel: GalleryCellViewModel) {
        imageView.image = viewModel.image
        titleLabel.text = viewModel.title
    }
}
