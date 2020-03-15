//
//  ChartMenuViewController.swift
//  test2
//
//  Created by Grimshaw, Aidan T on 3/14/20.
//  Copyright © 2020 baby body measurements. All rights reserved.
//

import UIKit
import CoreData

class ChartMenuViewController: UIViewController {
    
    //outlets
    
    //variables
    var recievedChild:Child? = nil
    
    //constants
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // get a reference to the second view controller
        if segue.destination is LineChartViewController {
            // set a variable in the second view controller with the String to pass
            let vc = segue.destination as? LineChartViewController
            vc?.recievedChild = recievedChild
        }
        else if segue.destination is BarChartViewController {
            let vc = segue.destination as? BarChartViewController
            vc?.recievedChild = recievedChild
        }
        
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
