//
//  ViewController.swift
//  test2
//
//  Created by Leenknecht, Aaron M on 1/30/20.
//  Copyright © 2020 baby body measurements. All rights reserved.
//

import UIKit
import CoreData

// Global Variables
let appDelegate = UIApplication.shared.delegate as? AppDelegate

class ViewController: UIViewController{
    
    //outlets
    
    @IBOutlet weak var pv: UIPickerView!
    
    //variable
    var childList = [Child]()
    var currentChild:Child? = nil
    
    //constants
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        callDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData{(done) in
            if done {
                print("Data is ready to be used in tableview")
                if childList.count > 0 {
                    pv.isHidden = false
                } else {
                    pv.isHidden = true
                }
            }
        }
        pv.reloadAllComponents()
    }
    
    func callDelegates(){
        pv.delegate = self
        pv.dataSource = self
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // get a reference to the second view controller
        if segue.destination is ARViewController {
            // set a variable in the second view controller with the String to pass
            let vc = segue.destination as? ARViewController
            vc?.recievedChild = currentChild
        }
    }

}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return childList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return childList[row].name
    }
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        print("row: ", row)
        print(childList[row].name!, childList[row].sex!,
            childList[row].birthHeight,
            childList[row].birthDate!)
        
        currentChild = childList[row]
    }
}

extension ViewController {
    func fetchData(completion: (_ complete: Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            print("fail")
            return
        }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Child")
        
        // try to get list of created children from database
        do {
            childList = try managedContext.fetch(request) as! [Child]
            print("data fetched, no issues")
            completion(true)
        } catch {
            print("unable to fetch data: ", error.localizedDescription)
            completion(false)
        }
        
        // set current selected child to the first in list
        if childList.count > 0 {
            currentChild = childList[0]
        }
    }
}

