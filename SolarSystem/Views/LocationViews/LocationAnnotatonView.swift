//
//  LocationAnnotatonView.swift
//  NASApp
//
//  Created by Max Ramirez on 4/10/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit
import Nuke
import CoreLocation

class LocationAnnotatonView: UIView {

    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationAddressLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configureWithImagery(_ imagery: EarthImageryData) {
        // set the locationNameLabel here? Perhaps with the coords and then parsing those coords into an actual address.
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: EarthImageryData.sharedInstance.lat!, longitude: EarthImageryData.sharedInstance.lon!)
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            if let locationName = placeMark.name {
                print(locationName)
                self.locationNameLabel.text = "LocationNameLabel"
            }
            
            if let street = placeMark.thoroughfare {
                print(street)
                self.locationAddressLabel.text = "LocationAddressLabel"
            }
            
            self.imageView.image = #imageLiteral(resourceName: "nasaLogo")

        }
    }

}
