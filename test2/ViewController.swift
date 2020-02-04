//
//  ViewController.swift
//  test2
//
//  Created by Leenknecht, Aaron M on 1/30/20.
//  Copyright © 2020 baby body measurements. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //outlets
    @IBOutlet weak var tv: UITableView!
    
    //variable
    
    
    //constants
    let cellid = "CellID"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        callDelegates()
    }

    func callDelegates(){
        tv.delegate = self
        tv.dataSource = self
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! TableViewCell
        cell.TaskLabel.text = "hello"
        return cell
    }
    
    
}
