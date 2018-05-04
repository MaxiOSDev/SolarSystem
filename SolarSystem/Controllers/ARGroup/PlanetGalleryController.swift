//
//  PlanetGalleryController.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/4/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit
import Nuke

class PlanetGalleryController: UICollectionViewController {

    let nukeManager = Nuke.Manager.shared
    var photos = [URL]()
    
    var chosenPlanet: String? {
        didSet {
            navigationItem.title = chosenPlanet
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2, height: screenWidth/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetGalleryCell", for: indexPath) as! GalleryCell

        
        return cell
    }

    
    func makeRequest(with url: URL) -> Request {
        return Request(url: url)
    }
    
}

extension PlanetGalleryController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell, let indexPath = collectionView?.indexPath(for: cell), let pageViewController = segue.destination as? PlanetGalleryPageController {

            pageViewController.indexOfCurrentPhoto = indexPath.row
        }
    }
}
