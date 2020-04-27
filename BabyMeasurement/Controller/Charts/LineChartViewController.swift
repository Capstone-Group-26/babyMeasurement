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
    // number array of number of days since birthDate
    var mDates:[Double] = []
    var upperBound:[Double] = []
    var lowerBound:[Double] = []
    
    // labels for first year of growth
    let labels = ["Birth", "1 month", "2 months", "3 months", "4 months", "5 months", "6 months", "7 months", "8 months", "9 months", "10 months", "11 months", "12 months"]
    
    // WHO 99th and 1st percentiles of baby girl growth
    let girlUpperBound = [53.5, 58.2, 61.8, 64.7, 67.1, 69.2, 71.0, 72.7, 74.3, 75.8, 77.2, 78.6, 80.0]
    let girlLowerBound = [44.8, 49.1, 52.3, 54.9, 57.1, 58.9, 60.5, 61.9, 63.2, 64.5, 65.7, 66.9, 68.0]
    
    // WHO 99th and 1st percentiles of baby boy growth
    let boyLowerBound = [45.5, 50.2, 53.8, 56.7, 59.0, 61.0, 62.6, 64.1, 65.5, 66.8, 68.0, 69.1, 70.2]
    let boyUpperBound = [54.3, 59.3, 63.1, 66.2, 68.7, 70.8, 72.6, 74.2, 75.7, 77.2, 78.6, 80.0, 81.3]
    
    //constants
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let test = recievedChild
        print("In line chart controller, child name ", test?.name ?? "Child passed in was null")
        // multiply by cm to inches scalar
        if (recievedChild!.sex == "Male"){
            upperBound = boyUpperBound.map { $0 * 0.393701 }
            lowerBound = boyLowerBound.map { $0 * 0.393701 }
        }else {
            upperBound = girlUpperBound.map { $0 * 0.393701 }
            lowerBound = girlLowerBound.map { $0 * 0.393701 }
        }
        
        let measurements = recievedChild?.measurements!
        
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        heightInches.append(recievedChild!.birthHeight)
        mDates.append(0)
        for elem in measurements! {
            // convert metric to inches
            heightInches.append((elem as! Measurement).height * 39.3700787)
            print(formatter.string(from: (elem as! Measurement).date!))
            // get months by getting days between birth and measurement and dividing by 30
            mDates.append(Double(calendar.dateComponents([.day], from: recievedChild!.birthDate!, to: (elem as! Measurement).date!).day!) / 30.0)
        }
        print(heightInches)
        print(mDates)
        
        let data = LineChartData()
        var lineChartEntry1 = [ChartDataEntry]()
        
        // set 1 x axis bar per month
        LineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:labels)
        LineChartView.xAxis.granularity = 1
        
        // adding line chart for 99th percentile to graph
        for i in 0..<upperBound.count {
            lineChartEntry1.append(ChartDataEntry(x: Double(i), y: Double(upperBound[i]) ))
        }
        let line1 = LineChartDataSet(entries: lineChartEntry1, label: "99th percentile")
        data.addDataSet(line1)
        
        // adding line chart for child entity measurements to graph
        if (heightInches.count > 0) {
            var lineChartEntry2 = [ChartDataEntry]()
            for i in 0..<heightInches.count {
                lineChartEntry2.append(ChartDataEntry(x: Double(mDates[i]), y: Double(heightInches[i]) ))
            }
            let line2 = LineChartDataSet(entries: lineChartEntry2, label: "Your baby")
            line2.colors = [NSUIColor.green]
        data.addDataSet(line2)
        }
        
        // adding line chart for 1st percentile to graph
        if (lowerBound.count > 0) {
            var lineChartEntry3 = [ChartDataEntry]()
            for i in 0..<lowerBound.count {
                lineChartEntry3.append(ChartDataEntry(x: Double(i), y: Double(lowerBound[i]) ))
            }
            let line3 = LineChartDataSet(entries: lineChartEntry3, label: "1st percentile")
            line3.colors = [NSUIColor.red]
            data.addDataSet(line3)
        }
        self.LineChartView.data = data

    }
    
    
}
