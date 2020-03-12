//
//  DemoListViewController.swift
//  test2
//
//  Created by Leenknecht, Aaron M on 3/5/20.
//  Copyright © 2020 baby body measurements. All rights reserved.
//

#if canImport(UIKit)
    import UIKit
#endif

private struct ItemDef {
    let title: String
    let subtitle: String
    let `class`: AnyClass
}

class DemoListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    private var itemDefs = [
                            
                    ItemDef(title: "Bar Chart",
                            subtitle: "A simple demonstration of the bar chart.",
                            class: BarChartViewController.self),

                            
                    ItemDef(title: "Multiple Lines Chart",
                            subtitle: "A line chart with multiple DataSet objects. One color per DataSet.",
                            class: MultipleLinesChartViewController.self),

                ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Charts Demonstration"
        self.tableView.rowHeight = 70
        //FIXME: Add TimeLineChart
        
    }
}

extension DemoListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemDefs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let def = self.itemDefs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = def.title
        cell.detailTextLabel?.text = def.subtitle
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let def = self.itemDefs[indexPath.row]
        
        let vcClass = def.class as! UIViewController.Type
        let vc = vcClass.init()
        
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
