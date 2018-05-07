//
//  SolarSystemTests.swift
//  SolarSystemTests
//
//  Created by Max Ramirez on 5/7/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import XCTest
import MapKit
@testable import SolarSystem

class SolarSystemTests: XCTestCase {
    
    // API Client
    let client = NASAClient()
    // Stored array properties to hold the parsed data
    var mockEarthImagery = EarthImageryData.sharedInstance //MockEarthImagery.sharedInstance
    
    let tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    let mapView = MKMapView(frame: .zero)
    
    lazy var earthSearchDataSource: EarthSearchDatasource = {
        return EarthSearchDatasource(tableView: tableView, searchController: searchController, mapView: mapView, container: nil)
    }()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
    }
    
    
    
    //MARK: - Testing Parse of GalleryFeature
    func testGalleryJSONFetch() {
        fetchGalleryCollection()
    }
    
    // Gallery Test Helper
    func fetchGalleryCollection() {
        var galleryCollectionData = [GalleryItems]()
        XCTAssert(galleryCollectionData.count == 0, "Gallery Collection Array is not equal to 0")

        client.search(withTerm: "galaxy") { result in
            switch result {
            case .success(let results):
                galleryCollectionData = results.collection.items
                XCTAssert(galleryCollectionData.count > 0, "Gallery Collection count is less than 1")
            case .failure(let error):
                print("Error \(error)")
            }
        }
        print("HIT 2 \(galleryCollectionData.count)")
        
    }
    
    // MARK: - Rover API Tests
    func testMarsRoversJSONFetch() {
        fetchCuritosityCollection()
        fetchOpportunityCollection()
        fetchSpiritCollection()
    }
    
    // Curiosity Test Helper
    func fetchCuritosityCollection() {
        var curiosityCollectionData = [Photo]()
        XCTAssert(curiosityCollectionData.count == 0, "Curiosity Collection Array count is not 0")

        client.fetchRover("curiosity") { result in
            switch result {
            case .success(let results):
                curiosityCollectionData = results.photos
                XCTAssert(curiosityCollectionData.count > 0, "Curiosity Collection Array is 0")
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    // Opportunity Test Helper
    func fetchOpportunityCollection() {
        var opportunityCollectionData = [Photo]()
        XCTAssert(opportunityCollectionData.count == 0, "Opportunity Collection Array count is not 0")

        client.fetchRover("opportunity") { result in
            switch result {
            case .success(let results):
                opportunityCollectionData = results.photos
                XCTAssert(opportunityCollectionData.count > 0, "Curiosity Collection Array is 0")
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    // Spirit Test Helper
    func fetchSpiritCollection() {
        var spiritCollectionData = [Photo]()
        XCTAssert(spiritCollectionData.count == 0, "Spirit Collection Array count is not 0")

        client.fetchRover("spirit") { result in
            switch result {
            case .success(let results):
                spiritCollectionData = results.photos
                XCTAssert(spiritCollectionData.count > 0, "Curiosity Collection Array is 0")
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    // MARK: - Earth Imagery Test
    func testEarthImagery() {
        fetchEarthImageryData()
    }
    
    // Earth Imagery Test Helper
    func fetchEarthImageryData() {
        let newClient = MockEarthImageryClient()
        let longitude: CLLocationDegrees = 0.1340118
        let latitude: CLLocationDegrees = 51.5097724
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        var locationName: String = ""
        var locationDate: String = ""
        var locationAddress: String = ""
        var locationUrl: String = ""
        XCTAssert(locationName == "" && locationDate == "" && locationUrl == "" && locationAddress == "", "String is not empty")

        newClient.fetchEarthImageryWith(coords: longitude, latitude) { result in
            switch result {
            case .success(let results):
                guard let results = results else { return }
            locationName = placemark.name!
            locationDate = results.date
            locationUrl = results.url
            locationAddress = self.earthSearchDataSource.parseAddress(selectedItem: placemark)
            XCTAssert(locationName == "Savini At Criterion", "Location Name is not correct")
            XCTAssert(locationDate == "2013-12-24T10:53:50", "Location Date is not correct")
            XCTAssert(locationUrl == "https://earthengine.googleapis.com/api/thumb?", "Location URL is not correct")
            XCTAssert(locationAddress == "224 Piccadilly, London England", "Location Address is not correct")
                
            case .failure(let error):
                print("Error for earth imagery \(error)")
            }
        }
    }
    
    // Earth Imagery Mock Class
    class MockEarthImageryClient: NASAClient {

        override func fetchEarthImageryWith(coords lon: Double, _ lat: Double, completion: @escaping (Result<NASAEarthImagery?, APIError>) -> Void) {
            let url = URL(string: "https://api.nasa.gov/planetary/earth/imagery/?lon=\(lon)&lat=\(lat)&api_key=FibfgEAUvuS0knr5woA5aNckz4QWk12iB5KHkBKr")
            let request = URLRequest(url: url!)
            self.fetch(with: request, decode: { (json) -> NASAEarthImagery? in
                guard let results = json as? NASAEarthImagery else { return nil }
                return results
            }, completion: completion)
        }
    }
    
    // MARK: - AR PlanetGallery Fetch
    func testPlanetGalleryFetch() {
        fetchSun()
        fetchMercury()
        fetchVenus()
        fetchEarth()
        fetchMars()
        fetchJupiter()
        fetchSaturn()
        fetchUranus()
        fetchNeptune()
        fetchPluto()
    }
    
    func fetchSun() {
        var planetCollection = [GalleryItems]()
        PlanetGalleryData.sharedInstance.planet = "sun"
        XCTAssert(planetCollection.count == 0, "Sun collection array count is greater than 0")
        client.search(withTerm: "sun") { result in
            switch result {
            case .success(let results):
                planetCollection = results.collection.items
                XCTAssert(planetCollection.count > 0, "Sun Collection count is less than 1")
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    func fetchMercury() {
        var planetCollection = [GalleryItems]()
        PlanetGalleryData.sharedInstance.planet = "mercury"
        XCTAssert(planetCollection.count == 0, "Planet collection array count is greater than 0")
        client.search(withTerm: "mercury") { result in
            switch result {
            case .success(let results):
                planetCollection = results.collection.items
                XCTAssert(planetCollection.count > 0, "Planet Collection count is less than 1")
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    func fetchVenus() {
        var planetCollection = [GalleryItems]()
        PlanetGalleryData.sharedInstance.planet = "venus"
        XCTAssert(planetCollection.count == 0, "Planet collection array count is greater than 0")
        client.search(withTerm: "venus") { result in
            switch result {
            case .success(let results):
                planetCollection = results.collection.items
                XCTAssert(planetCollection.count > 0, "Planet Collection count is less than 1")
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    func fetchEarth() {
        var planetCollection = [GalleryItems]()
        PlanetGalleryData.sharedInstance.planet = "earth"
        XCTAssert(planetCollection.count == 0, "Planet collection array count is greater than 0")
        client.search(withTerm: "earth") { result in
            switch result {
            case .success(let results):
                planetCollection = results.collection.items
                XCTAssert(planetCollection.count > 0, "Planet Collection count is less than 1")
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    func fetchMars() {
        var planetCollection = [GalleryItems]()
        PlanetGalleryData.sharedInstance.planet = "mars"
        XCTAssert(planetCollection.count == 0, "Planet collection array count is greater than 0")
        client.search(withTerm: "mars") { result in
            switch result {
            case .success(let results):
                planetCollection = results.collection.items
                XCTAssert(planetCollection.count > 0, "Planet Collection count is less than 1")
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    func fetchJupiter() {
        var planetCollection = [GalleryItems]()
        PlanetGalleryData.sharedInstance.planet = "jupiter"
        XCTAssert(planetCollection.count == 0, "Planet collection array count is greater than 0")
        client.search(withTerm: "jupitar") { result in
            switch result {
            case .success(let results):
                planetCollection = results.collection.items
                XCTAssert(planetCollection.count > 0, "Planet Collection count is less than 1")
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    func fetchSaturn() {
        var planetCollection = [GalleryItems]()
        PlanetGalleryData.sharedInstance.planet = "saturn"
        XCTAssert(planetCollection.count == 0, "Planet collection array count is greater than 0")
        client.search(withTerm: "saturn") { result in
            switch result {
            case .success(let results):
                planetCollection = results.collection.items
                XCTAssert(planetCollection.count > 0, "Planet Collection count is less than 1")
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    func fetchUranus() {
        var planetCollection = [GalleryItems]()
        PlanetGalleryData.sharedInstance.planet = "uranus"
        XCTAssert(planetCollection.count == 0, "Planet collection array count is greater than 0")
        client.search(withTerm: "uranus") { result in
            switch result {
            case .success(let results):
                planetCollection = results.collection.items
                XCTAssert(planetCollection.count > 0, "Planet Collection count is less than 1")
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    func fetchNeptune() {
        var planetCollection = [GalleryItems]()
        PlanetGalleryData.sharedInstance.planet = "neptune"
        XCTAssert(planetCollection.count == 0, "Planet collection array count is greater than 0")
        client.search(withTerm: "neptune") { result in
            switch result {
            case .success(let results):
                planetCollection = results.collection.items
                XCTAssert(planetCollection.count > 0, "Planet Collection count is less than 1")
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    func fetchPluto() {
        var planetCollection = [GalleryItems]()
        PlanetGalleryData.sharedInstance.planet = "pluto"
        XCTAssert(planetCollection.count == 0, "Planet collection array count is greater than 0")
        client.search(withTerm: "pluto") { result in
            switch result {
            case .success(let results):
                planetCollection = results.collection.items
                XCTAssert(planetCollection.count > 0, "Planet Collection count is less than 1")
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
}
