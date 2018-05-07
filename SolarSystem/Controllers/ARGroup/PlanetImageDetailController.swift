//
//  PlanetImageDetailController.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/4/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import ARKit

import UIKit
import Nuke

class PlanetImageDetailController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    var photo: GalleryItems!
    var nukeManager = Nuke.Manager.shared
    var textData: String?
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        textView.text = textData
        if let url = url {
            nukeManager.loadImage(with: url, into: imageView)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissTap(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PlanetImageDetailController: UITextViewDelegate {}
