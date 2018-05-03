//
//  SearchResultController.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/2/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit
import Nuke

class SearchResultController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var dataSource: GalleryDatasource = {
       return GalleryDatasource(collectionView: collectionView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = dataSource
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2, height: screenWidth/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ImageData.shared.imageState = .placeholder
    }
    
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToVC1", sender: self)
    }
    
}
