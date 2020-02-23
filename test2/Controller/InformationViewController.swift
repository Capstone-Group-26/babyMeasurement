//
//  InformationViewController.swift
//  test2
//
//  Created by Leenknecht, Aaron M on 2/4/20.
//  Copyright © 2020 baby body measurements. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {

    var height = 22.0
    var bornHeight = 19.2
    var temp: Double?

    
//    let height: Double
//    let bornHeight: Double
//    let dif: Double
    

    
    @IBOutlet weak var heightValueLabel: UILabel!
    @IBOutlet weak var bornHeightValueLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightPercentileLabel: UILabel!
    @IBOutlet weak var weeksOldLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //temp = findDif(x: height, y: bornHeight)
        heightValueLabel.text = "Height: \(height) inches"
        bornHeightValueLabel.text = "Grown Since Birth: \(round((findDif(x: height, y: bornHeight))*1000) / 1000) inches"
        nameLabel.text = "Aaron,"
        heightPercentileLabel.text = "Height Percentile: 67"
        weeksOldLabel.text = "Weeks Old: 6"

    }
    
    func findDif(x: Double, y: Double) -> Double {
        return x - y;
    }


}
