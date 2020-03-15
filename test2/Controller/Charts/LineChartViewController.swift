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
    
    //outlets
    @IBOutlet weak var LineChartView: LineChartView!

    //variables
    var recievedChild:Child? = nil
    var heightInches:[Double] = []
    let labels = ["1 month","2 months", "3 months", "4 months", "5 months", "6 months"]
    let upperBound = [20.2, 20.8, 21.3, 21.4, 21.9, 22.8]
    let lowerBound = [18.2, 18.8, 19.3, 19.4, 19.9, 20.8]
    
    //constants

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let test = recievedChild
        print("In line chart controller, child name ", test?.name ?? "Child passed in was null")
        
        let measurements = recievedChild?.measurements!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        for elem in measurements! {
            // convert metric to inches
            heightInches.append((elem as! Measurement).height * 39.3700787)
            print(formatter.string(from: (elem as! Measurement).date!))
        }
        
        
        let data = LineChartData()
        var lineChartEntry1 = [ChartDataEntry]()
        
        LineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:labels)
        LineChartView.xAxis.granularity = 1

        for i in 0..<upperBound.count {
            lineChartEntry1.append(ChartDataEntry(x: Double(i), y: Double(upperBound[i]) ))
        }
        let line1 = LineChartDataSet(entries: lineChartEntry1, label: "100th percentile")
        data.addDataSet(line1)
        
        
        if (heightInches.count > 0) {
            var lineChartEntry2 = [ChartDataEntry]()
            for i in 0..<heightInches.count {
                lineChartEntry2.append(ChartDataEntry(x: Double(i), y: Double(heightInches[i]) ))
            }
            let line2 = LineChartDataSet(entries: lineChartEntry2, label: "Your baby")
            line2.colors = [NSUIColor.green]
        data.addDataSet(line2)
        }
        
        
        if (lowerBound.count > 0) {
            var lineChartEntry3 = [ChartDataEntry]()
            for i in 0..<lowerBound.count {
                lineChartEntry3.append(ChartDataEntry(x: Double(i), y: Double(lowerBound[i]) ))
            }
            let line3 = LineChartDataSet(entries: lineChartEntry3, label: "0th percentile")
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
