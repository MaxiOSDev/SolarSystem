//
//  GalleryImageOperation.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/1/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class GalleryJSONOperation: Operation {
    let gallery: GalleryItems?
    let data: GalleryData
    let client: NASAClient
    private let nukeManager = Nuke.Manager.shared
    init(gallery: GalleryItems?, data: GalleryData, client: NASAClient) {
        self.gallery = gallery ?? nil
        self.data = data
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
        
        client.itemWith(link: nil, data: data) { [unowned self] result in
            switch result {
            case .success(let results):

                    for i in results {
                        if self.data.mediaType == "video" {
                            if i.range(of: "small_thumb_00002.png") != nil {
                                let url = URL(string: i)!
                                print("URL A: \(url)")

                                self.data.imageState = .downloaded
                                self.data.imageURL = url

                            }
                            
                        } else if self.data.mediaType == "image" {
                            if i.range(of: "thumb.jpg") != nil {
                                let url = URL(string: i)!
                                print("URL B: \(url)")

                                self.data.imageState = .downloaded
                                self.data.imageURL = url
                                self.nukeManager.loadImage(with: url, completion: { (image) in
                                    self.data.image = image.value
                                })

                            }
                        }
                    }
                
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

















