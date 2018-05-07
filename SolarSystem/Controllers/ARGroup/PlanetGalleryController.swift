//
//  PlanetGalleryController.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/4/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit
import AVKit
import Nuke

class PlanetGalleryController: UICollectionViewController {

    let nukeManager = Nuke.Manager.shared
    
    
    var chosenPlanet: String? {
        didSet {
            navigationItem.title = chosenPlanet
        }
    }
    
    lazy var dataSource: GalleryDatasource = {
        return GalleryDatasource(collectionView: self.collectionView!)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.dataSource = dataSource
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for item in dataSource.pageData {
            let image = dataSource.object(array: item.collection.items, at: indexPath)
            for data in image.data {
                if data.mediaType == "video" {
                    print("\(dataSource.selectedVideoUrl)")
                    for index in dataSource.selectedVideoUrl {
                        for (key, value) in index {
                            //    print("Key: \(key), Value: \(value.row)")
                            if value == indexPath {
                                let videoURL = key
                                //      print("Video URL \(videoURL)")
                                let player = AVPlayer(url: videoURL)
                                let playerViewController = storyboard?.instantiateViewController(withIdentifier: "AVVideoController") as! AVPlayerViewController
                                //AVPlayerViewController()
                                playerViewController.player = player
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.present(playerViewController, animated: true) {
                                        playerViewController.player?.play()
                                    }
                                }
                            }
                        }
                    }
                } else if data.mediaType == "image" {
                    print("\(dataSource.selectedImageUrl)")
                  //  performSegue(withIdentifier: "pageControllerSegue", sender: self)
                }
            }
        }
    }
}

extension PlanetGalleryController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Sender here: \(sender)")
        if let cell = sender as? GalleryCell, let cellIndexPath = collectionView?.indexPath(for: cell) {
            let pageViewController = segue.destination as! PlanetGalleryPageController
            
//            pageViewController.indexOfCurrentPhoto = indexPath.row
//            for data in dataSource.pageData {
//                pageViewController.photoLinks = data.collection.items
//            }
        }
    }
}
