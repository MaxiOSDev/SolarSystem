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

    private var pageData = [GallerySearchResult]()
    private var client = NASAClient()
    let nukeManager = Nuke.Manager.shared
    private var newData: GalleryData?
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
            for result in pageData {
                let items = result.collection.items
                
                let item = object(array: items, at: indexPath)
                for data in item.data {
                    let viewModel = GalleryCellViewModel(gallery: data)
                    cell.configure(with: viewModel)
                    
                    if data.imageState == .placeholder {
                        
                        downloadImageData(for: data, atIndexPath: indexPath)
                   //     print("Each Item here: \(data.title), \(data.imageState), \(data.imageURL)\n")
                    } else {
               //         print("Worked? \(data.title), \(data.imageState) \(data.imageURL)\n")
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

    func downloadImageData(for item: GalleryData, atIndexPath indexPath: IndexPath) {
        if let _ = pendingOperations.downloadsInProgress[indexPath] {
            return
        }
        
            let downloader = GalleryJSONOperation(gallery: nil, data: item, client: client)
            
            downloader.completionBlock = {
                if downloader.isCancelled {
                    return
                }
                
                DispatchQueue.main.async {
                    self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
            //        print("Inside downloadImageData: \(downloader.data.title),\(downloader.data.imageURL), \(downloader.data.imageState)\n")
                    self.newData = downloader.data
                    self.collectionView.reloadItems(at: [indexPath])
                }
            }
            
            pendingOperations.downloadsInProgress[indexPath] = downloader
            pendingOperations.downloadQueue.addOperation(downloader)


    }
    
    func downloadNextPage(for galleryResult: GallerySearchResult, atIndexPath indexPath: IndexPath) {
        if let _ = pendingOperations.downloadsInProgress[indexPath] {
            return
        }
        for data in pageData {
            let downloader = NASAGalleryOperation(gallery: data, client: client)
            
            downloader.completionBlock = {
                if downloader.isCancelled {
                    return
                }
                
                DispatchQueue.main.async {
                    
                    self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                    
                    self.collectionView.reloadItems(at: [indexPath])
                }
            }
            pendingOperations.downloadsInProgress[indexPath] = downloader
            pendingOperations.downloadQueue.addOperation(downloader)
        }

    }
}








