//
//  ViewController.swift
//  CIS*4500 Assignment3
//  March 2nd, 2018
//  Created by Christian Cornelis on 2018-02-20.
//  Copyright © 2018 Christian Cornelis. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //reading file and storing k, l, and R values.
        let vals = readFile()
        let k = vals[0]
        let l = vals[1]
        let R = vals[2]
        let sceneView = SCNView(frame: self.view.frame)
        self.view.addSubview(sceneView)
        
        //define scene
        let scene = SCNScene()
        sceneView.scene = scene
        
        //define camera
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: -3.0, y: 3.0, z: 3.0)
        
        //define ambient light
        let ambientLight = SCNLight()
        ambientLight.type = SCNLight.LightType.ambient
        ambientLight.color = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        cameraNode.light = ambientLight
        
        //define spotlight
        let spotlight = SCNLight()
        spotlight.type = SCNLight.LightType.spot
        spotlight.spotInnerAngle = 25.0
        spotlight.spotOuterAngle = 90.0
        spotlight.castsShadow = true
        let lightNode = SCNNode()
        lightNode.light = spotlight
        lightNode.position = SCNVector3(x: 1.5, y: 1.5, z: 1.5)
        
        var nodes:[SCNNode] = [] //array to hold all SCNNodes to be added to the scene
        
        //define cube to be created and setting one cube in th middle of the screen to direct the camera
        let cube = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0.0)
        let cameraTarget = SCNNode(geometry: cube)
        cameraTarget.position = SCNVector3(x:0.0, y:0.0, z:0.0)
        
        //creating 10000 SCNNode objects
        for i in 0...10000{
            
            let toAdd = SCNNode(geometry: cube)
            let t = Double(i) * 0.06282 //t calculation
            //performing calculations for x and z coordinates.
            let kEqn = 1.0-k
            let xEqn1 = kEqn * cos(t)
            let zEqn1 = kEqn * sin(t)
            let xEqn2 = cos((kEqn/k) * t)
            let zEqn2 = sin((kEqn/k) * t)
            let x = R * (xEqn1 + l * k * xEqn2)
            let z = R * (zEqn1 + l * k * zEqn2)
            toAdd.position = SCNVector3(x:Float(x), y:0.0, z:Float(z))
            nodes.append(toAdd) //adding to array to be added later
        }
        
        let planeGeometry = SCNPlane(width: 70.0, height: 70.0)
        let planeNode = SCNNode(geometry: planeGeometry)
        planeNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(-90), y: 0, z: 0)
        planeNode.position = SCNVector3(x: 0, y: -0.5, z: 0)
        
        //making all cubes blue
        let blueMaterial = SCNMaterial()
        blueMaterial.diffuse.contents = UIColor.blue
        cube.materials = [blueMaterial]
        
        //setting background material
        let greenMaterial = SCNMaterial()
        greenMaterial.diffuse.contents = UIColor.green
        planeGeometry.materials = [greenMaterial]
        
        //lighting constraints
        let constraint = SCNLookAtConstraint(target: cameraTarget)
        constraint.isGimbalLockEnabled = true
        cameraNode.constraints = [constraint]
        lightNode.constraints = [constraint]
        
        //adding all components to the scene
        scene.rootNode.addChildNode(lightNode)
        scene.rootNode.addChildNode(cameraNode)
        scene.rootNode.addChildNode(cameraTarget)
        scene.rootNode.addChildNode(planeNode)
        
        //adding all SCNNode cubes to the scene
        for i in 0...10000{
            scene.rootNode.addChildNode(nodes[i])
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //function to read the file and return the values in an array of doubles.
    func readFile()->[Double]{
        if let dataFile = Bundle.main.path(forResource: "input", ofType: "txt") {
            do {
                //reading input file.
                let fileData = try String(contentsOfFile: dataFile, encoding: .utf8)
                let characterSet = CharacterSet(charactersIn: ",")
                let data = fileData.components(separatedBy: characterSet)
                
                var toReturn:[Double] = []
                //trimming all whitespaces and newlines.
                for i in data{
                    if (Double(i.trimmingCharacters(in: .whitespacesAndNewlines)) != nil)
                    {
                        toReturn.append((Double(i.trimmingCharacters(in: .whitespacesAndNewlines)))!)
                    }
                }
                return toReturn
                
            }
            catch {
                print("Error: \(error)")
            }
        }
        
        return []
    }
}

