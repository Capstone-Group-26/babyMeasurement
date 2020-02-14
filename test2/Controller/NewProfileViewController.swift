//
//  NewProfileViewController.swift
//  test2
//
//  Created by Leenknecht, Aaron M on 2/4/20.
//  Copyright © 2020 baby body measurements. All rights reserved.
//

import UIKit
import CoreData

class NewProfileViewController: UIViewController {
    
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var DOB: UIDatePicker!
    
    @IBOutlet weak var bornHeight: UITextField!
    
    @IBOutlet weak var bioSex: UISegmentedControl!
    
    @IBAction func saveButton(_ sender: Any) {
        print("save button pressed")
        saveTask{ (done) in
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
    
    func saveTask(completion: (_ finished: Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            print("fail")
            return
        }
        
        if (firstName.text?.isEmpty ?? true) {
            print("firstName is empty")
            return
        }
        
        if (lastName.text?.isEmpty ?? true) {
            print("lastName is empty")
            return
        }
        
        if (bornHeight.text?.isEmpty ?? true) {
            print("bornHeight is empty")
            return
        }
        
        let newChild = Child(context: managedContext)
        
        newChild.name = firstName.text!+" "+lastName.text!
        
        newChild.sex = bioSex.titleForSegment(at: bioSex.selectedSegmentIndex)
        
        newChild.birthHeight = Double(bornHeight.text!)!
        
        newChild.birthDate = DOB.date

        do {
            try managedContext.save()
            print("data saved")
            completion(true)
        } catch {
            print("failed ", error.localizedDescription)
            completion(false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
