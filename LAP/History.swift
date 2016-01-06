//
//  World.swift
//  LAPTest
//
//  Created by kevin on 12/10/15.
//  Copyright © 2015 Kevin Argumedo. All rights reserved.
//

import Foundation
import UIKit

class History: UIViewController {
    @IBOutlet var options: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        //opens up side menu on button tap
        options.target = self.revealViewController()
        options.action = Selector("revealToggle:")
        
        
        //allows user to swipe left from the right side to pull out nav.
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        
        
    }
}
