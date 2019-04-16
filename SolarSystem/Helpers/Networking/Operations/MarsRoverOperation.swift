//
//  MarsRoverOperation.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/3/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import Nuke
import UIKit

class MarsRoverOperation: Operation {
    let rover: String
    let roverData: Photo
    let client: NASAClient
    
    init(rover: String, roverData: Photo, client: NASAClient) {
        self.rover = rover
        self.roverData = roverData
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
        
        client.fetchRover(rover) { [weak self] result in
            if let strongSelf = self {
                switch result {
                case .success(let results):
                    for data in results.photos {
                        if let url = URL(string: data.imgSrc) {
//                            Nuke.loadImage(with: url, completion: { (image) in
//                                strongSelf.roverData.image = image.value
//                                strongSelf.roverData.imageState = .downloaded
//                                strongSelf.roverData.id = data.id
//                                ImageData.shared.add(with: nil, image: image.value!, imageState: .downloaded)
//                            })
                            
                            ImagePipeline.shared.loadImage(with: url, progress: nil, completion: { (response, pipelineError) in
                                if let pipelineError = pipelineError {
                                    print("We failed with pipelineError: \(pipelineError)")
                                }
                                
                                strongSelf.roverData.image = response?.image
                                strongSelf.roverData.imageState = .downloaded
                                strongSelf.roverData.id = data.id
                                ImageData.shared.add(with: nil, image: response!.image, imageState: .downloaded)
                            })
                        }
                    }
                    strongSelf.isExecuting = false
                    strongSelf.isFinished = true
                case .failure(let error):
                    print("Error here: \(error)")
                    strongSelf.isExecuting = false
                    strongSelf.isFinished = true
                }
            }

        }
    }
    
}


















