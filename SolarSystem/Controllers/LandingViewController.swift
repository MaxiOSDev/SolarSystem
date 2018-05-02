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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func featureTapped(_ sender: UIButton) {
        buttonTapped(sender)
    }
    
    
    // MARK: - Helpers
    func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0: performSegue(withIdentifier: "showGalleryVC", sender: self)
        case 1: print("showRoverVC")
        case 2: print("showEyeVC")
        case 3: print("showARVC")
        default:
            print("Hit default clause")
        }
    }


}

