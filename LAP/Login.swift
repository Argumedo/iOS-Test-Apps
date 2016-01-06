//
//  Login.swift
//  LAPTest
//
//  Created by kevin on 12/11/15.
//  Copyright © 2015 Kevin Argumedo. All rights reserved.
//

import Foundation
//
//  LoginViewcontroller.swift
//  LAP
//
//  Created by kevin on 11/9/15.
//  Copyright © 2015 Kevin Argumedo. All rights reserved.
//

import Foundation
import UIKit

class Login: UIViewController {
    
    //fields for the login view
    @IBOutlet var userName: UITextField!
    @IBOutlet var userPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //login Button
    @IBAction func loginAction(sender: AnyObject) {
        //grabs data that user input in the fields.
        let uName = String(userName.text!)
        let uPassword = String(userPassword.text!)

        //If either field is empty, display alert.
        if(uName.isEmpty || uPassword.isEmpty)
        {
            self.displayAlertMessage("The fields are empty!")
            return
        }
        
        //check will confirm username and password match
        var check = false;
        
        RestApiManager.sharedInstance.getUser(uName, pass: uPassword){ json -> Void in

            //grabs the user returned with that username and password.
            for (_,usr) in json
            {
                if(String(usr["username"]) == uName && uPassword == String(usr["password"]))
                {
                    check =  true;
                }
            }
            
            print(check)
            
            //checks is password and username match
            if(check)
            {
                dispatch_async(dispatch_get_main_queue()) {
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                    self.performSegueWithIdentifier("Login", sender: self)
                }
            }
            else
            {
                dispatch_async(dispatch_get_main_queue()) {
                    self.displayAlertMessage("Username and Password do not match")

                }
            }
            
        }

    }
    
    //sends user to registration view
    @IBAction func Register(sender: AnyObject) {
        
        self.performSegueWithIdentifier("toRegister", sender: self)
    }
    
    
    //display customized alert 
    func displayAlertMessage(uMessage: String)
    {
        let myAlert = UIAlertController(title:"Alert", message: uMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okButton)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
}