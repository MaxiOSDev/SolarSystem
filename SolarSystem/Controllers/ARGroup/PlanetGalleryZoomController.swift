//
//  PlanetGalleryZoomController.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/4/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit
import Nuke

class PlanetGalleryZoomController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var photo: GalleryItems!
    var image: UIImage!
    var nukeManager = Nuke.Manager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let storyboard = storyboard else { return }
        let detailVC = storyboard.instantiateViewController(withIdentifier: String(describing: PlanetImageDetailController.self)) as! PlanetImageDetailController
        detailVC.modalTransitionStyle = .crossDissolve
        detailVC.photo = photo

        self.present(detailVC, animated: true, completion: nil)
    }
    
    
    
}
