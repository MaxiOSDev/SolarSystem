//
//  GalleryDatasource.swift
//  SolarSystem
//
//  Created by Max Ramirez on 4/30/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class GalleryDatasource: NSObject, UICollectionViewDataSource {

    private let collectionView: UICollectionView
    // This pageData array holds the data
     var pageData = [GallerySearchResult]()
    private var client = NASAClient()
    
    // NukeManager singlton
    let nukeManager = Nuke.Manager.shared
    
    
    let pendingOperations = PendingOperations()
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        for data in pageData {
            count = data.collection.items.count
            return data.collection.items.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCell
        // In order to get all the way to my data I have to use a bunch of for loops.
        // If there is a better way please let me know
            for result in pageData {
                let items = result.collection.items
                
                let item = object(array: items, at: indexPath)
                for data in item.data {
                    let viewModel = GalleryCellViewModel(gallery: data)
                    cell.configure(with: viewModel)
                    
                    // Checks if the imageState is not .downloaded. if not then download imageData, no more check for .placeholder. Wouldn't work.
                    if data.imageState != .downloaded {
                        downloadImageData(for: item, atIndexPath: indexPath)
                    } else {
                        cell.progressIndicator.hidesWhenStopped = true
                        cell.progressIndicator.stopAnimating()
                        
                    }
                }
            }

        return cell
    }
    
    // MARK: Helpers
    
    func object(array: [GalleryItems]?, at indexPath: IndexPath) -> GalleryItems {

        return array![indexPath.row]
    }

    
    func pageUpdate(with data: [GallerySearchResult]) {
        
        self.pageData = data
    }
    
    func update(_ object: GalleryItems, at indexPath: IndexPath) {
        
        var items: [GalleryItems] = []
        for data in pageData {
            items.append(contentsOf: data.collection.items)
        }
        
           return items[indexPath.row] = object
    }

    // The following is the method. Yes. The method I learnt from the courses, and I used it in this project.
    func downloadImageData(for item: GalleryItems, atIndexPath indexPath: IndexPath) {
        if let _ = pendingOperations.downloadsInProgress[indexPath] {
            return
        }
        
            let downloader = GalleryJSONOperation(gallery: item, client: client)
        
        //    pendingOperations.downloadQueue.maxConcurrentOperationCount = 1
            downloader.completionBlock = {
                if downloader.isCancelled {
                    return
                }
                // Here If you uncomment the print statement below you can see that the downloader.data indeed did change.
                // But the collectionView does not change, and the original GalleryData within cellForItem is still .placeholder not .downloaded.
                DispatchQueue.main.async {
                    self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
            //        print("Inside downloadImageData: \(downloader.data.title),\(downloader.data.imageURL), \(downloader.data.imageState)\n")
                    self.collectionView.reloadItems(at: [indexPath])
                }
            }
            
            pendingOperations.downloadsInProgress[indexPath] = downloader
            pendingOperations.downloadQueue.addOperation(downloader)
    }
    
    // Following method reserved for future use but and is not used
    
//    func downloadNextPage(for galleryResult: GallerySearchResult, atIndexPath indexPath: IndexPath) {
//        if let _ = pendingOperations.downloadsInProgress[indexPath] {
//            return
//        }
//        for data in pageData {
//            let downloader = NASAGalleryOperation(gallery: data, client: client)
//
//            downloader.completionBlock = {
//                if downloader.isCancelled {
//                    return
//                }
//
//                DispatchQueue.main.async {
//
//                    self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
//
//                    self.collectionView.reloadItems(at: [indexPath])
//                }
//            }
//            pendingOperations.downloadsInProgress[indexPath] = downloader
//            pendingOperations.downloadQueue.addOperation(downloader)
//        }
//
//    }
}








