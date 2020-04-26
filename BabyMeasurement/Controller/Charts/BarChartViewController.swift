//
//  BarChartViewController.swift
//  test2
//
//  Created by Leenknecht, Aaron M on 2/20/20.
//  Copyright © 2020 baby body measurements. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {
    //outlets
    @IBOutlet weak var BarChartView: BarChartView!
    
    //variables
    var recievedChild:Child? = nil
    
    let players = ["Ozil","Ramsey", "Laca", "Auba", "Xhak", "Torreira"]
    let goals = [20.2, 20.8, 21.3, 21.4, 21.9, 22.8]
    
    //constants
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let test = recievedChild
        print("In bar chart controller, child name ", test?.name ?? "Child passed in was null")
        
        customizeChart(dataPoints: players, values: goals.map{ Double($0) })
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
      var dataEntries: [BarChartDataEntry] = []
      for i in 0..<dataPoints.count {
        let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
        dataEntries.append(dataEntry)
      }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Previous 6 height measurements")
      let chartData = BarChartData(dataSet: chartDataSet)
      BarChartView.data = chartData
    }


}
