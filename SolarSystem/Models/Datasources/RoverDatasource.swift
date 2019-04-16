//
//  RoverDatasource.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/3/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class RoverDatasource: NSObject, UICollectionViewDataSource {
    
    private let collectionView: UICollectionView
    private let client = NASAClient()
    var segmentedControlIndex: Int?
    var curiosityData: [Photo]?
    var opporunityData: [Photo]?
    var spiritData: [Photo]?

    let pendingOperations = PendingOperations()
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentedControlIndex == 0 {
            if let images = curiosityData {
                return images.count
            }
        } else if segmentedControlIndex == 1 {
            if let images = opporunityData {
                return images.count
            }
        } else if segmentedControlIndex == 2 {
            if let images = spiritData {
                return images.count
            }
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoverCell", for: indexPath) as! RoverCell
        
        
                if segmentedControlIndex == 0 {
                    if let curiosityData = curiosityData {
                        let item = curiosityData[indexPath.row]
                        let request = self.makeRequest(with: item.imgSrc)
//                        Nuke.loadImage(with: request!) { (image) in
//                            item.image = image.value
//                            cell.imageView.image = image.value
//
//                        }
                        
                        Nuke.loadImage(with: request!, into: cell.imageView)
                         cell.imageID.text = String(item.id)
                        
                    }
                } else if segmentedControlIndex == 1 {
                    if let opportunityData = opporunityData {
                        let item = opportunityData[indexPath.row]
                        let request = self.makeRequest(with: item.imgSrc)
//                        Nuke.loadImage(with: request!) { (image) in
//                            item.image = image.value
//                            cell.imageView.image = image.value
//                            cell.imageID.text = String(item.id)
//                        }
                        
                        Nuke.loadImage(with: request!, into: cell.imageView)
                        cell.imageID.text = String(item.id)
                    }
                } else if segmentedControlIndex == 2 {
                    if let spiritData = spiritData {
                        let item = spiritData[indexPath.row]
                        let request = self.makeRequest(with: item.imgSrc)
                        
                        
//                        Nuke.loadImage(with: request!) { (image) in
//                            item.image = image.value
//                            cell.imageView.image = image.value
//                            cell.imageID.text = String(item.id)
//                        }
                        Nuke.loadImage(with: request!, into: cell.imageView)
                        cell.imageID.text = String(item.id)
                    }
                }

        return cell
    }
    
    func updateCuriosity(with data: [Photo]) {
        self.curiosityData = data
    }
    
    func updateOpportunity(with data: [Photo]) {
        self.opporunityData = data
    }
    
    func updateSpirit(with data: [Photo]) {
        self.spiritData = data
    }
    
    func makeRequest(with string: String) -> ImageRequest? {
        guard let url = URL(string: string) else { return nil }
        return ImageRequest(url: url)
    }
    
//    func downloadImageData(for rover: String, data: Photo, atIndexPath indexPath: IndexPath) {
//        if let _ = pendingOperations.downloadsInProgress[indexPath] {
//            return
//        }
//
//        let downloader = MarsRoverOperation(rover: rover, roverData: data, client: client)
//
//        downloader.completionBlock = {
//            if downloader.isCancelled {
//                return
//            }
//
//            DispatchQueue.main.async {
//                self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
//                print("Downloader: \(downloader.roverData.image) \(downloader.roverData.imgSrc) \(downloader.rover) \(downloader.roverData.imageState)")
//                self.collectionView.reloadItems(at: [indexPath])
//            }
//        }
//
//        pendingOperations.downloadsInProgress[indexPath] = downloader
//        pendingOperations.downloadQueue.addOperation(downloader)
//    }

}














