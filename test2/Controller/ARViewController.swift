//
//  ARViewController.swift
//  test2
//
//  Created by Leenknecht, Aaron M on 1/30/20.
//  Copyright © 2020 baby body measurements. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import CoreData

class ARViewController: UIViewController, ARSCNViewDelegate {
    
    //outlets
    @IBOutlet var sceneView: ARSCNView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func SaveButtonPressed(_ sender: Any) {
        print("save button pressed")
        saveChild{ (done) in
            if done {
                print("we need to return now")
                // move view back to previous screen
                navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            } else {
                print("try again")
            }
        }
    }
    
    //variables
    var dotNodes = [SCNNode]()
    var textNode = SCNNode()
    var recievedChild:Child? = nil
    var distance:Double? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let test = recievedChild
        print(test?.name ?? "Child passed in was null")
        
        saveButton.isEnabled = false
        saveButton.setTitle("Add Points", for: .disabled)
        saveButton.setTitle("Save", for: .normal)
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if dotNodes.count >= 2 {
            for dot in dotNodes {
                dot.removeFromParentNode()
            }
            dotNodes = [SCNNode]()
        }
        
        if let touchLocation = touches.first?.location(in: sceneView) {
            let hitTestResults = sceneView.hitTest(touchLocation, types: .featurePoint)
            
            if let hitResult = hitTestResults.first {
                addDot(at: hitResult)
            }
            
        }
    }
    
    func addDot(at hitResult : ARHitTestResult) {
        let dotGeometry = SCNSphere(radius: 0.005)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        
        dotGeometry.materials = [material]
        
        let dotNode = SCNNode(geometry: dotGeometry)
        dotNode.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
        
        sceneView.scene.rootNode.addChildNode(dotNode)
        
        dotNodes.append(dotNode)
        
        if dotNodes.count >= 2 {
            calculate()
        }
    }
    
    func calculate (){
        let start = dotNodes[0]
        let end = dotNodes[1]
        
        print(start.position)
        print(end.position)
        
        let tempD = Double(
            sqrt(
                pow(end.position.x - start.position.x, 2) +
                pow(end.position.y - start.position.y, 2) +
                pow(end.position.z - start.position.z, 2)
            )
        )
        // allow save button to be pressed and set distance for saving
        distance = tempD
        saveButton.isEnabled = true
        
        updateText(text: "\(abs(tempD))", atPosition: end.position)
    }
    
    func updateText(text: String, atPosition position: SCNVector3){
        textNode.removeFromParentNode()
        
        let textGeometry = SCNText(string: text, extrusionDepth: 1.0)
        textGeometry.firstMaterial?.diffuse.contents = UIColor.red
        
        textNode = SCNNode(geometry: textGeometry)
        textNode.position = SCNVector3(position.x, position.y + 0.01, position.z)
        textNode.scale = SCNVector3(0.01, 0.01, 0.01)
        
        sceneView.scene.rootNode.addChildNode(textNode)
        
    }
    
    func saveChild(completion: (_ finished: Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            print("fail")
            return
        }
        let newMeasurement = Measurement(context: managedContext)
        newMeasurement.height = distance!
        newMeasurement.date = Date()
        newMeasurement.child = recievedChild
        
        do {
            try managedContext.save()
            print("data saved")
            completion(true)
        } catch {
            print("failed ", error.localizedDescription)
            completion(false)
        }
        print(recievedChild?.measurements! ?? "measurements list failed")
    }
}
