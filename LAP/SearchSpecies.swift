//
//  SearchSpecies.swift
//  LAP
//
//  Created by kevin on 12/10/15.
//  Copyright © 2015 Kevin Argumedo. All rights reserved.
//

import Alamofire
import Foundation

class SearchSpecies: UIViewController {
    
    @IBOutlet var species: UITextField!
    
    @IBOutlet var options: UIBarButtonItem!
    
    //contains a list of objects with data for each specie
    var speciesArray = [JSON]();
    
    override func viewDidLoad() {
        
        
        options.target = self.revealViewController()
        options.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        print(speciesArray)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //searches what was typed in the field
    @IBAction func searchButton(sender: AnyObject) {
        let specie = String(species.text!)
        
        //if field is empty, display alert
        if(specie.isEmpty)
        {
            self.displayAlertMessage("Please type in a specie to search")
            return
        }
        
        //HTTP request that will return any species containing the string typed.
        RestApiManager.sharedInstance.getSpecies(specie){ json -> Void in
            
            if(!json.isEmpty)
            {
                for (_,spc) in json
                {
                    self.speciesArray.append(spc)
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    //sends the data from the json and names
                    self.performSegueWithIdentifier("dSpecies", sender: self)
                }
            }
        }
    }
    
    //displays custom alert message
    func displayAlertMessage(uMessage: String)
    {
        let myAlert = UIAlertController(title:"Alert", message: uMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okButton)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    //prepares data to be sent to a different view.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //sends the list of results to the list of results.
        if (segue.identifier == "dSpecies")
        {
            let dest = segue.destinationViewController as? SpeciesResults
            dest?.results = speciesArray;
            
        }
    }
}