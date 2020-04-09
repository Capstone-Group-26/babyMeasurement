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
    @IBOutlet weak var helpText: UITextField!
    
    // variables
    var dotNodes = [SCNNode]()
    var textNode = SCNNode()
    var recievedChild:Child? = nil
    var distance:Double? = nil
    var saveAlert:UIAlertController = UIAlertController(
               title: "Save this measurement?",
               message: "",
               preferredStyle: .alert
           )
    
    // constants
    let INCHES_IN_METER = 39.3700787;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set help text
        helpText.textAlignment = .center
        helpText.borderStyle = .none
        helpText.font = .systemFont(ofSize: 16)
        helpText.textColor = .white
        helpText.backgroundColor = .black
        helpText.text = "Place first point"
        
        // initialize alert dialog
        let saveAction = UIAlertAction(
            title: "Save",
            style: .default
        ) {
            (action) in
                print("Saving child's height...'")
                self.saveChild{ (done) in
                    if done {
                        print("Save successful")
                        // move view back to previous screen
                        self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                     } else {
                         print("try again")
                     }
                }
        }
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel) {
                (action) in
                    self.clearNodes()
        }
        
        saveAlert.addAction(saveAction)
        saveAlert.addAction(cancelAction)
        
        let test = recievedChild
        print(test?.name ?? "Child passed in was null")
        
        // Set the view's delegate
        sceneView.delegate = self
//        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
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
            clearNodes()
        }
        
        if let touchLocation = touches.first?.location(in: sceneView) {
            let hitTestResults = sceneView.hitTest(touchLocation, types: .featurePoint)
            
            if let hitResult = hitTestResults.first {
                addDot(at: hitResult)
            }
            
        }
        
        if dotNodes.count == 1 {
            helpText.text = "Place second point"
        }
    }
    
    func clearNodes() {
        for dot in dotNodes {
            dot.removeFromParentNode()
        }
        dotNodes = [SCNNode]()
        
        // reset help text
        helpText.text = "Place first point"
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
            
            // Empty help text
            helpText.text = ""
            
            // Display height in alert dialog
            let heightInches = (distance ?? 0.0) * INCHES_IN_METER
            saveAlert.message = "\(String(format: "%.2f", heightInches)) inches"
            present(saveAlert, animated: true, completion: nil)
        }
    }
    
    func calculate (){
        let start = dotNodes[0]
        let end = dotNodes[1]
        
        print(start.position)
        print(end.position)
        
        distance = Double(
            sqrt(
                pow(end.position.x - start.position.x, 2) +
                pow(end.position.y - start.position.y, 2) +
                pow(end.position.z - start.position.z, 2)
            )
        )
        
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
