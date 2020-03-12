//
//  LineChartViewController.swift
//  test2
//
//  Created by Leenknecht, Aaron M on 2/20/20.
//  Copyright © 2020 baby body measurements. All rights reserved.
//

import UIKit
import Charts

class LineChartViewController: UIViewController {
    
    @IBOutlet weak var LineChartView: LineChartView!
    
    let players = ["1 month","2 months", "3 months", "4 months", "5 months", "6 months"]
    let x1 = [20.2, 20.8, 21.3, 21.4, 21.9, 22.8]
    let x2 = [22.2, 22.8, 23.3, 24.4, 24.9, 25.8]
    let x3 = [18.2, 18.8, 19.3, 19.4, 19.9, 20.8]
 

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let data = LineChartData()
        var lineChartEntry1 = [ChartDataEntry]()
        
        LineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:players)
        LineChartView.xAxis.granularity = 1

        for i in 0..<x1.count {
            lineChartEntry1.append(ChartDataEntry(x: Double(i), y: Double(x1[i]) ))
        }
        let line1 = LineChartDataSet(entries: lineChartEntry1, label: "Your baby")
        data.addDataSet(line1)
        if (x2.count > 0) {
            var lineChartEntry2 = [ChartDataEntry]()
            for i in 0..<x2.count {
                lineChartEntry2.append(ChartDataEntry(x: Double(i), y: Double(x2[i]) ))
            }
            let line2 = LineChartDataSet(entries: lineChartEntry2, label: "100 percentile")
            line2.colors = [NSUIColor.green]
        data.addDataSet(line2)
        }
        if (x3.count > 0) {
            var lineChartEntry3 = [ChartDataEntry]()
            for i in 0..<x3.count {
                lineChartEntry3.append(ChartDataEntry(x: Double(i), y: Double(x3[i]) ))
            }
            let line3 = LineChartDataSet(entries: lineChartEntry3, label: "0 percentile")
            line3.colors = [NSUIColor.red]
            data.addDataSet(line3)
        }
        self.LineChartView.data = data

    }
    
    
    //your baby
    func setx1(){
        
    }
    
    //100 percentile
    func setx2(){
        
    }
    
    //0 percentile
    func setx3(){
        
    }
    
    
}
