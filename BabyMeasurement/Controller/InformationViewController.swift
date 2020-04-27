//
//  InformationViewController.swift
//  test2
//
//  Created by Leenknecht, Aaron M on 2/4/20.
//  Copyright © 2020 baby body measurements. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //variables
    var bornHeight:Double = 0
    var recievedChild:Child? = nil
    var currentMeasurement:Measurement? = nil
    
    // constants
    let INCHES_IN_METERS = 39.3700787
    

    
    
    // outlets
    @IBOutlet weak var bornHeightValueLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weeksOldLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var dataSelector: UISegmentedControl!

    
    @IBAction func indexChanged(_ sender: Any) {
        let height1 = (currentMeasurement?.height ?? 0.0) * INCHES_IN_METERS
        bornHeight = recievedChild?.birthHeight ?? 0.0
        switch dataSelector.selectedSegmentIndex
        {
        case 0:
            bornHeightValueLabel.text = "\(String(format: "%.2f", bornHeight)) inches"
        case 1:
            bornHeightValueLabel.text = "\(String(format: "%.2f", findDif(x: height1 , y: bornHeight))) inches"
        case 2:
            guard let birthDate = recievedChild?.birthDate else { return }
            guard let currentMeasurementDate = currentMeasurement?.date else { return }
            let daysOld = Calendar.current.dateComponents([.day], from: birthDate, to: currentMeasurementDate).day
            bornHeightValueLabel.text = "\((daysOld ?? 0) / 7)"
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        
        bornHeight = recievedChild?.birthHeight ?? 0.0
        // By default, select the most recent measurement
        guard let numMeasurements = recievedChild?.measurements?.count else { return }
        if(numMeasurements == 0){
        navigationController?.popViewController(animated: false)
        }
        else{
        picker.selectRow(numMeasurements-1, inComponent: 0, animated: true)
        currentMeasurement = recievedChild?.measurements?[numMeasurements-1] as? Measurement
            if(recievedChild?.sex == "Male"){
                avatarImage.image = UIImage(named: "maleSymbol")
            }
            else{
                avatarImage.image = UIImage(named: "femaleSymbol")
            }
            //avatarImage.layer.borderWidth = 2
            avatarImage.layer.masksToBounds = false
            //avatarImage.layer.borderColor = UIColor.black.cgColor
            //avatarImage.layer.cornerRadius = avatarImage.frame.height/2
            avatarImage.clipsToBounds = true
            
            nameLabel.text = recievedChild?.name
        // Set values of text fields
        setText()
        }
    }
    
    func setText(){
        
        let height = (currentMeasurement?.height ?? 0.0) * INCHES_IN_METERS
        if(dataSelector.titleForSegment(at: dataSelector.selectedSegmentIndex) ==  "Born Height"){
            bornHeightValueLabel.text = "\(String(format: "%.2f", bornHeight)) inches"
        }
        else if(dataSelector.titleForSegment(at: dataSelector.selectedSegmentIndex) ==  "Growth"){
            bornHeightValueLabel.text = "\(String(format: "%.2f", findDif(x: height , y: bornHeight))) inches"
        }
        else{
            guard let birthDate = recievedChild?.birthDate else { return }
            guard let currentMeasurementDate = currentMeasurement?.date else { return }
            let daysOld = Calendar.current.dateComponents([.day], from: birthDate, to: currentMeasurementDate).day
            bornHeightValueLabel.text = "\((daysOld ?? 0) / 7)"
        }
    }

    
    func findDif(x: Double, y: Double) -> Double {
        return x - y;
    }
    
    
    // Picker view functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return recievedChild?.measurements?.count ?? 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        return dateFormatter.string(from: (recievedChild?.measurements?[row] as AnyObject).date);
    }
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
            print("row: ", row)
        print(recievedChild?.measurements?[row] as Any)
        
        currentMeasurement = recievedChild?.measurements?[row] as? Measurement
        setText()
    }
}
