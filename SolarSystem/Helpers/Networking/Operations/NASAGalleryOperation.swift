//
//  NASAGalleryOperation.swift
//  SolarSystem
//
//  Created by Max Ramirez on 4/30/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation

// This operation subclass is going to parse the next page once the user gets to the end of images in the array within the collectionview
class NASAGalleryOperation: Operation {
    var gallery: GallerySearchResult
    let client: NASAClient
    
    init(gallery: GallerySearchResult, client: NASAClient) {
        self.gallery = gallery
        self.client = client
        super.init()
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    private var _finished = false
    
    override private(set) var isFinished: Bool {
        get {
            return _finished
        }
        
        set {
            willChangeValue(forKey: "isFinished")
            _finished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
    
    private var _executing = false
    
    override private(set) var isExecuting: Bool {
        get {
            return _executing
        }
        
        set {
            willChangeValue(forKey: "isExecuting")
            _executing = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    override func start() {
        if isCancelled {
            isFinished = true
            return
        }
        
        isExecuting = true
        
        client.parseNextPage(with: gallery.collection.links) { [unowned self] result in
            switch result {
            case .success(let results):
                self.gallery.collection.items.append(contentsOf: results.collection.items)
                self.isExecuting = false
                self.isFinished = true
            case .failure(let error):
                print(error)
                self.isExecuting = false
                self.isFinished = true
            }
        }
    }
}











