//
//  SpeciesResults.swift
//  LAPTest
//
//  Created by kevin on 12/14/15.
//  Copyright © 2015 Kevin Argumedo. All rights reserved.
//

import Foundation
import UIKit


class SpeciesResults: UITableViewController
{
    //list of json data with species information
    var results = [JSON]();
    
    @IBOutlet var options: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.hidden = true

        //displays side navigation when user presses options button
        options.target = self.revealViewController()
        options.action = Selector("revealToggle:")
        
        //displays side nav when user swipes left from rightmost side of screen.
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    //decides number of rows to be displayed depending on the number of items in list of results
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    //what is displayed in each cell.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        // sets the cell with a species name.
        cell.textLabel?.text = String(results[indexPath.row]["name"])
        
        return cell
    }
    
    //prepares data to be sent to another screen.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        
        let navDest = segue.destinationViewController as! UINavigationController
        
        let vSpecie = navDest.viewControllers.first as! ViewSpecie
        
        
        //sends list of JSON Data with results
        vSpecie.results = self.results
        
        //Sends the data of the specie selected by user.
        vSpecie.specie = self.results[indexPath.row]

    }
}

