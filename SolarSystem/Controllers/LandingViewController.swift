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
            client.fetchRover("curiosity") { result in
                switch result {
                case .success(let results):
                    
                    roverVC.roverData = results
                case .failure(let error):
                    let alertController = UIAlertController(title: "An error occured", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}

