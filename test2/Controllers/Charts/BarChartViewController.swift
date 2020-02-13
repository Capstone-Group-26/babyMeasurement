//
//  BarChartViewController.swift
//  test2
//
//  Created by Leenknecht, Aaron M on 2/13/20.
//  Copyright © 2020 baby body measurements. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {


    @IBOutlet weak var BarChartHeight: BarChartView!
    
    let players = ["Ozil", "Ramsey", "Laca", "Auba", "Xhaka", "Torreira"]
    let goals = [6, 8, 26, 30, 8, 10]
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        customizeChart(dataPoints: players, values: goals.map{ Double($0) })
    }
    

    func customizeChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
          let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
          dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Dates")
        let chartData = BarChartData(dataSet: chartDataSet)
        BarChartHeight.data = chartData
    }

}
