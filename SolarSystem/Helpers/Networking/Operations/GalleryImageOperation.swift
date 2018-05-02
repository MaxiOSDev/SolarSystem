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

// Operation Subclass to get the imageURL from the collection.json URL within the JSON. Inside an array of GalleryItems
// This operation subclass was brough to you by the ResturantReviews Course. besides the client api call.
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
                // after getting the results after parsing the collection.json URL, I only wanted certain imageURLs.
                //https://images-assets.nasa.gov/video/Space-to-Ground_171_170407/collection.json is an example url within the JSON that I parse.
                // small thumb0002 for videos. As I want to go overboard and play the videos as well. Well was hoping to.
                // And thumb.jpg when the media type is no video, but only image.
                    for i in results {
                        if self.data.mediaType == "video" {
                            if i.range(of: "small_thumb_00002.png") != nil {
                                let url = URL(string: i)!
                                print("URL A: \(url)")
                                // I have the url now. So I use Nuke, to convert it to an image. Which I then tried to place in the model.
                                // I also make the imageState .download after I have the image. I thought I had done it.
                               
                                self.data.imageURL = url
                                self.nukeManager.loadImage(with: url, completion: { (image) in
                                    self.data.image = image.value
                                    self.data.imageState = .downloaded
                                })
                            // You can even use a print statment for example print("\(self.data.title),\(self.data.imageURL),\(self.data.image), \(self.data.imageState)")
                            // To check that indeed the model's data has changed. YES, but wait it's no time to celebate because it didn't entirely work.
                            // I'll explain why in GalleryDatasource.swift within the method "downloadImageData"
                            }
                            
                        } else if self.data.mediaType == "image" {
                            if i.range(of: "thumb.jpg") != nil {
                                let url = URL(string: i)!
                                print("URL B: \(url)")


                                self.data.imageURL = url
                                self.nukeManager.loadImage(with: url, completion: { (image) in
                                    self.data.image = image.value
                                    self.data.imageState = .downloaded
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

















