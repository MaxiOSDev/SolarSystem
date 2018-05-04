//
//  EyeInSkyController.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/4/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import MapKit

class EyeInSkyController: UIViewController, MapViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapContainerView: UIView!
    @IBOutlet weak var containerBottomConstraint: NSLayoutConstraint!
    
    lazy var searchController: UISearchController = {
        return UISearchController(searchResultsController: nil)
    }()
    
    lazy var dataSource: EarthSearchDatasource = {
        return EarthSearchDatasource(tableView: tableView, searchController: searchController, mapView: mapView, container: mapContainerView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchResultsUpdater = dataSource
        searchController.delegate = dataSource
        self.navigationItem.titleView = searchController.searchBar
        
        
        definesPresentationContext = true
        dataSource.mapViewDelegate = self
        mapView.delegate = dataSource
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showMap(for view: UIView) {
        containerBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hideMap() {
        containerBottomConstraint.constant = 686
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    
}
