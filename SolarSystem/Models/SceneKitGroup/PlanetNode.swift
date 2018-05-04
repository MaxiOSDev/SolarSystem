//
//  PlanetNode.swift
//  SolarSystem
//
//  Created by Max Ramirez on 5/4/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import SceneKit

class PlanetNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: 0.2)
        self.geometry?.firstMaterial?.isDoubleSided = true
        self.geometry?.firstMaterial?.transparency = 1
        self.geometry?.firstMaterial?.shininess = 50
        let action = SCNAction.rotate(by: 360 * CGFloat((Double.pi)/180), around: SCNVector3(x: 0, y: 1, z: 0), duration: 8)
        
        let repeatAction = SCNAction.repeatForever(action)
        
        self.runAction(repeatAction)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class EarthNode: PlanetNode {
    override init() {
        super.init()
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "earthmap1k")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class SunNode: PlanetNode {
    override init() {
        super.init()
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "sunmap")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class MercuryNode: PlanetNode {
    override init() {
        super.init()
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "mercurymap")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class VenusNode: PlanetNode {
    override init() {
        super.init()
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "venusmap")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class MarsNode: PlanetNode {
    override init() {
        super.init()
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "mars_1k_color")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class JupitarNode: PlanetNode {
    override init() {
        super.init()
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "jupitermap")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class SaturnNode: PlanetNode {
    override init() {
        super.init()
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "saturnmap")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class UranusNode: PlanetNode {
    override init() {
        super.init()
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "uranusmap")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class NeptuneNode: PlanetNode {
    override init() {
        super.init()
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "neptunemap")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class PlutoNode: PlanetNode {
    override init() {
        super.init()
        self.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "plutomap1k")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
