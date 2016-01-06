//
//  ViewSpecie.swift
//  LAPTest
//
//  Created by kevin on 12/15/15.
//  Copyright © 2015 Kevin Argumedo. All rights reserved.
//

import AlamofireImage
import Alamofire
import Foundation
import UIKit



class ViewSpecie: UIViewController {
    
    var replace = "localhost:1337/"

    //list of results
    var results = [JSON]()
    
    //specie the user is currently viewing
    var specie : JSON!

    @IBOutlet var options: UIBarButtonItem!
    
    //text and image displayed.
    @IBOutlet var textView: UITextView!
    @IBOutlet var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //displays side navigation menu
        options.target = self.revealViewController()
        options.action = Selector("revealToggle:")
        
        //displays side navigation when user swipes left from the rightmost side of screen.
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //sets title to the specie's name
        navigationController?.navigationBar.topItem?.title = String(specie["name"])
        
        //does not allow text view to be edited.
        textView.editable = false
        
        //sets description on specie from API
        textView.text = String(specie["description"])
        
        // ***************** ALTER THIS WHEN WE GET A PERMANENT DATABASE ****************
        // replaces localhost with whatever the current URL for local host is (The IP)
        let newLink = String(specie["pictureUrl"]).stringByReplacingOccurrencesOfString("localhost", withString: replace, options: NSStringCompareOptions.LiteralSearch, range: nil)

        //HTTP request that grabs the picture with the link provided.
        Alamofire.request(.GET, newLink)
            .responseImage { response in
                debugPrint(response)
                
                if let image = response.result.value {
                    print("image downloaded: \(image)")
                }
                
                //displays the image retrieved.
                self.imageView.image = UIImage(data: response.data!)
        }

    }

    //sends the user back to the list of results.
    @IBAction func back(sender: AnyObject) {
        
        print(results)
        self.performSegueWithIdentifier("backResults", sender: self)
    }
    
    //prepares data to be sent to another screen.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //sends the list of results back to the table in order to display the results
        if(segue.identifier == "backResults")
        {
            let dest = segue.destinationViewController as? SpeciesResults
            dest?.results = self.results;
        }
    }
}