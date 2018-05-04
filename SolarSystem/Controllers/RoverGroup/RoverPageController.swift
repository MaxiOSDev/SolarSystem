//
//  RoverPageController.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/4/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit

class RoverPageController: UIPageViewController {
    
    var photos: [Photo] = []
    var indexOfCurrentPhoto: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        if let photoViewerController = photoViewerController(with: photos[indexOfCurrentPhoto]) {
            setViewControllers([photoViewerController], direction: .forward, animated: false, completion: nil)
        }
    }
    
    func photoViewerController(with photo: Photo) -> RoverViewerController? {
        guard let storyboard = storyboard, let photoViewerController = storyboard.instantiateViewController(withIdentifier: "RoverViewerController") as? RoverViewerController else { return nil}
        
        photoViewerController.photo = photo
        return photoViewerController
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "roverUnwindSegue", sender: self)
    }
    
    @IBAction func editImage(_ sender: UIBarButtonItem) {
        guard let storyboard = storyboard, let editVC = storyboard.instantiateViewController(withIdentifier: "EditImageController") as? EditImageController else { return }
        editVC.modalTransitionStyle = .crossDissolve
        editVC.photo = photos[indexOfCurrentPhoto]
        let navController = UINavigationController(rootViewController: editVC)
        navController.navigationBar.barTintColor = .black
        navController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.present(navController, animated: true, completion: nil)
    }
}

extension RoverPageController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let photoVC = viewController as? RoverViewerController, let index = photos.index(of: photoVC.photo!) else { return nil }
        
        if index == photos.startIndex {
            return nil
        } else {
            let indexBefore = photos.index(before: index)
            let photo = photos[indexBefore]
            return photoViewerController(with: photo)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let photoVC = viewController as? RoverViewerController, let index = photos.index(of: photoVC.photo!) else { return nil }
        
        if index == photos.index(before: photos.endIndex) {
            return nil
        } else {
            let indexAfter = photos.index(after: index)
            let photo = photos[indexAfter]
            return photoViewerController(with: photo)
        }
    }
    
}
