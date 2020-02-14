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
    var pickerData: [String] = [String]()
    
    //constants
//    let cellid = "CellID"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        callDelegates()
        pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
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
        print("row: ", row)
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }
}
extension ViewController {
    func fetchData(completion: (_ complete: Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            print("fail")
            return
        }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Child")
        do {
            childList = try managedContext.fetch(request) as! [Child]
            print("data fetched, no issues")
            completion(true)
        } catch {
            print("unable to fetch data: ", error.localizedDescription)
            completion(false)
        }
        
    
    }
}

