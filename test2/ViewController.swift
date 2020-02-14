//
//  ViewController.swift
//  test2
//
//  Created by Leenknecht, Aaron M on 1/30/20.
//  Copyright © 2020 baby body measurements. All rights reserved.
//

import UIKit

// Global Variables
let appDelegate = UIApplication.shared.delegate as? AppDelegate

class ViewController: UIViewController{
    
    //outlets
    
    @IBOutlet weak var pv: UIPickerView!
    //variable
    var pickerData: [String] = [String]()
    
    //constants
//    let cellid = "CellID"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        callDelegates()
        pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
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
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
}


//extension ViewController: UITableViewDataSource, UITableViewDelegate {
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! TableViewCell
//        cell.TaskLabel.text = "hello"
//        return cell
//    }
//
//
//}
