//
//  RoverViewerController.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/4/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class RoverViewerController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    var photo: Photo?
    var nukeManager = Nuke.Manager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let request = Request(url: URL(string: (photo?.imgSrc)!)!)
        nukeManager.loadImage(with: request, into: imageView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedImageView(_ sender: UITapGestureRecognizer) {
        guard let storyboard = storyboard else { return }
        
        let zoomController = storyboard.instantiateViewController(withIdentifier: String(describing: RoverZoomController.self)) as! RoverZoomController
        zoomController.modalTransitionStyle = .crossDissolve
        zoomController.photo = photo
        
        self.present(zoomController, animated: true, completion: nil)
    }
}
