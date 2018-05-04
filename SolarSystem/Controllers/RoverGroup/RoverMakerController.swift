//
//  RoverMakerController.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/3/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit

class RoverMakerController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func roverUnwindToVC1(segue: UIStoryboardSegue) { }
    let client = NASAClient()
    
    var roverData: NASARover? {
        didSet {
            passCuriosityData()
            collectionView.reloadData()
        }
    }
    
    lazy var datasource: RoverDatasource = {
       return RoverDatasource(collectionView: collectionView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.selectedSegmentIndex = 0
        datasource.segmentedControlIndex = segmentedControl.selectedSegmentIndex
        collectionView.dataSource = datasource
        //datasource.updateData(roverData!)
        // Do any additional setup after loading the view.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2, height: screenWidth/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
    }
    
    @IBAction func roverSelected(_ sender: UISegmentedControl) {
        datasource.segmentedControlIndex = sender.selectedSegmentIndex
        collectionView.reloadData()
        if sender.selectedSegmentIndex == 0 {
            print("curiosity")
        } else if sender.selectedSegmentIndex == 1 {
            print("opportunity")
        } else if sender.selectedSegmentIndex == 2 {
            print("spirit")
        }
    }
    
    func passCuriosityData() {
        if let roverData = roverData {
          datasource.updateCuriosity(with: roverData.photos)
        }
        
        parseOpportunityData()
    }
    
    func parseOpportunityData() {
        client.fetchRover("opportunity") { [weak self] result in
            if let strongSelf = self {
                switch result {
                case .success(let results):
                    strongSelf.datasource.updateOpportunity(with: results.photos)
                    strongSelf.parseSpiritData()
                case .failure(let error):
                    print("Error here: \(error.localizedDescription)")
                }
            }

        }
    }
    
    func parseSpiritData() {
        client.fetchRover("spirit") { [weak self] result in
            if let strongSelf = self {
                switch result {
                case .success(let results):
                    strongSelf.datasource.updateSpirit(with: results.photos)
                case .failure(let error):
                    print("Error here: \(error.localizedDescription)")
                }
            }
        }
    }
}

extension RoverMakerController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRover" {
            if let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell), let navController = segue.destination as? UINavigationController {
                let pageViewController = navController.topViewController as! RoverPageController
                if datasource.segmentedControlIndex == 0 {
                    pageViewController.photos = datasource.curiosityData!
                } else if datasource.segmentedControlIndex == 1 {
                    pageViewController.photos = datasource.opporunityData!
                } else if datasource.segmentedControlIndex == 2 {
                    pageViewController.photos = datasource.spiritData!
                }
                pageViewController.indexOfCurrentPhoto = indexPath.row
            }
        }
    }
}









