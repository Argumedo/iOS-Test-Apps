//
//  BackTableVC.swift
//  LAPTest
//
//  Created by kevin on 12/10/15.
//  Copyright © 2015 Kevin Argumedo. All rights reserved.
//

import Foundation
import UIKit


class BackTableVC: UITableViewController
{
    var tableArray = [String]();
    var varView = Int()
    
    //options in the side navigation
    override func viewDidLoad() {
        tableArray = ["Map", "Search", "History", "Logout"]
    }
    
    //number of cells
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    //cell display
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(tableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = tableArray[indexPath.row]
        
        return cell
    }
}