//
//  ARPlanetController.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/4/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class PlanetGalleryData {
    static var sharedInstance = PlanetGalleryData()
    var planet: String?
}

@available(iOS 11.0, *)

class ARPlanetController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imagesBarButton: UIBarButtonItem!
    
    var newSun = SunNode()
    var newMercury = MercuryNode()
    var newVenus = VenusNode()
    var newEarth = EarthNode()
    var newMars = MarsNode()
    var newJupitar = JupitarNode()
    var newSaturn = SaturnNode()
    var newUranus = UranusNode()
    var newNeptune = NeptuneNode()
    var newPluto = PlutoNode()
    var dataManager = PlanetGalleryData.sharedInstance
    let client = NASAClient()

    var chosenPlanet: String?
    var alertController = UIAlertController(title: "Something went wrong", message: "Please wait and try again", preferredStyle: .alert)
    let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
    //    sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        alertController.addAction(action)
        let newEarth = EarthNode()
        let position = SCNVector3(0, 0, -0.9)
        addPlanetWith(position: position, node: newEarth, planet: Planet.earth, chosenPlanet: ChosenPlanet.earth)
        segmentedControl.selectedSegmentIndex = 3
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    @IBAction func planetChosen(_ sender: UISegmentedControl) {
        let position = SCNVector3(0, 0, -0.9)
        
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        
        if sender.selectedSegmentIndex == 0 {
            addPlanetWith(position: position, node: newSun, planet: Planet.sun, chosenPlanet: ChosenPlanet.sun)
        } else if sender.selectedSegmentIndex == 1 {
            
            addPlanetWith(position: position, node: newMercury, planet: Planet.mercury, chosenPlanet: ChosenPlanet.mercury)
        } else if sender.selectedSegmentIndex == 2 {
            addPlanetWith(position: position, node: newVenus, planet: Planet.venus, chosenPlanet: ChosenPlanet.venus)
        } else if sender.selectedSegmentIndex == 3 {
            addPlanetWith(position: position, node: newEarth, planet: Planet.earth, chosenPlanet: ChosenPlanet.earth)
        } else if sender.selectedSegmentIndex == 4 {
            addPlanetWith(position: position, node: newMars, planet: Planet.mars, chosenPlanet: ChosenPlanet.mars)
        } else if sender.selectedSegmentIndex == 5 {
            addPlanetWith(position: position, node: newJupitar, planet: Planet.jupiter, chosenPlanet: ChosenPlanet.jupiter)
        } else if sender.selectedSegmentIndex == 6 {
            addPlanetWith(position: position, node: newSaturn, planet: Planet.saturn, chosenPlanet: ChosenPlanet.saturn)
        } else if sender.selectedSegmentIndex == 7 {
            addPlanetWith(position: position, node: newUranus, planet: Planet.uranus, chosenPlanet: ChosenPlanet.uranus)
        } else if sender.selectedSegmentIndex == 8 {
            addPlanetWith(position: position, node: newNeptune, planet: Planet.neptune, chosenPlanet: ChosenPlanet.neptune)
        } else if sender.selectedSegmentIndex == 9 {
            addPlanetWith(position: position, node: newPluto, planet: Planet.pluto, chosenPlanet: ChosenPlanet.pluto)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        if let hit = sceneView.hitTest(touch.location(in: sceneView), options: nil).first {
            if segmentedControl.selectedSegmentIndex == 0 {
                newSun = hit.node as! SunNode
            } else if segmentedControl.selectedSegmentIndex == 1 {
                newMercury = hit.node as! MercuryNode
            } else if segmentedControl.selectedSegmentIndex == 2 {
                newVenus = hit.node as! VenusNode
            } else if segmentedControl.selectedSegmentIndex == 3 {
                newEarth = hit.node as! EarthNode
            } else if segmentedControl.selectedSegmentIndex == 4 {
                newMars = hit.node as! MarsNode
            } else if segmentedControl.selectedSegmentIndex == 5 {
                newJupitar = hit.node as! JupitarNode
            } else if segmentedControl.selectedSegmentIndex == 6 {
                newSaturn = hit.node as! SaturnNode
            } else if segmentedControl.selectedSegmentIndex == 7 {
                newUranus = hit.node as! UranusNode
            } else if segmentedControl.selectedSegmentIndex == 8 {
                newNeptune = hit.node as! NeptuneNode
            } else if segmentedControl.selectedSegmentIndex == 9 {
                newPluto = hit.node as! PlutoNode
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let touchPoint = touch.location(in: sceneView)
        if segmentedControl.selectedSegmentIndex == 0 {
            touchesMovedFor(node: newSun, withPoint: touchPoint)
        } else if segmentedControl.selectedSegmentIndex == 1 {
            touchesMovedFor(node: newMercury, withPoint: touchPoint)
        } else if segmentedControl.selectedSegmentIndex == 2 {
            touchesMovedFor(node: newVenus, withPoint: touchPoint)
        } else if segmentedControl.selectedSegmentIndex == 3 {
            touchesMovedFor(node: newEarth, withPoint: touchPoint)
        } else if segmentedControl.selectedSegmentIndex == 4 {
            touchesMovedFor(node: newMars, withPoint: touchPoint)
        } else if segmentedControl.selectedSegmentIndex == 5 {
            touchesMovedFor(node: newJupitar, withPoint: touchPoint)
        } else if segmentedControl.selectedSegmentIndex == 6 {
            touchesMovedFor(node: newSaturn, withPoint: touchPoint)
        } else if segmentedControl.selectedSegmentIndex == 7 {
            touchesMovedFor(node: newUranus, withPoint: touchPoint)
        } else if segmentedControl.selectedSegmentIndex == 8 {
            touchesMovedFor(node: newNeptune, withPoint: touchPoint)
        } else if segmentedControl.selectedSegmentIndex == 9 {
            touchesMovedFor(node: newPluto, withPoint: touchPoint)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        alertController.title = "Encountered Error: \(error.localizedDescription)"
        present(alertController, animated: true, completion: nil)
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        alertController.title = "Session Interrupted"
        present(alertController, animated: true, completion: nil)
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    // Helpers
    func addPlanetWith(position: SCNVector3, node: PlanetNode, planet: Planet, chosenPlanet: ChosenPlanet) {
        node.position = position
        sceneView.scene.rootNode.addChildNode(node)
        dataManager.planet = planet.rawValue
        self.chosenPlanet = chosenPlanet.rawValue
    }
    
    func touchesMovedFor(node: PlanetNode, withPoint touchPoint: CGPoint) {
        let zDepth = sceneView.projectPoint(node.position).z
        node.position = sceneView.unprojectPoint(SCNVector3(x: Float(touchPoint.x), y: Float(touchPoint.y), z: zDepth))
    }
}

extension ARPlanetController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlanetImages" {
            print("Segue identifier is okay")
            if let planetGalleryVC = segue.destination as? PlanetGalleryController {
                client.search(withTerm: self.chosenPlanet!) { result in
                    switch result {
                    case .success(let results):
                        planetGalleryVC.dataSource.pageUpdate(with: [results])
                        
                        planetGalleryVC.collectionView?.reloadData()
                    case .failure(let error):
                        let alertController = UIAlertController(title: "An error occured", message: "\(error.localizedDescription)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                        alertController.addAction(action)
                        planetGalleryVC.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}
