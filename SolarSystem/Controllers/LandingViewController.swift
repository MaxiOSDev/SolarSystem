//
//  LandingViewController.swift
//  SolarSystem
//
//  Created by Max Ramirez on 4/30/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBAction func unwindToVC1(segue: UIStoryboardSegue) {}
    
    let client = NASAClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRoverMakerVC" {
            let roverVC = segue.destination as! RoverMakerController
            client.fetchRover("curiosity") { [weak self] result in
                switch result {
                case .success(let results):
                    
                    roverVC.roverData = results
                case .failure(let error):
                    print("Error here: \(error.localizedDescription)")
                }
            }
        }
    }
}

