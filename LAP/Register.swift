//
//  Register.swift
//  LAPTest
//
//  Created by kevin on 12/12/15.
//  Copyright © 2015 Kevin Argumedo. All rights reserved.
//

import Alamofire
import Foundation


class Register: UIViewController {
    
    //fields displayed in the registration menu
    @IBOutlet var fName: UITextField!
    @IBOutlet var lName: UITextField!
    @IBOutlet var userName: UITextField!
    @IBOutlet var cin: UITextField!
    @IBOutlet var userPassword: UITextField!
    @IBOutlet var repeatUserPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButton(sender: AnyObject) {
        //grabs information input into fields
        let rFName = String(fName.text!)
        let rLName = String(lName.text!)
        let rCIN = String(cin.text!)
        let rUsername = String(userName.text!)
        let rUPassword = String(userPassword.text!)
        let rRPassword = String(repeatUserPassword.text!)
        var rID : String!
        
        var check = false;
        
        //if any field is empty then display alert
        if(rFName.isEmpty || rLName.isEmpty || rCIN.isEmpty || rUsername.isEmpty || rUPassword.isEmpty || rRPassword.isEmpty)
        {
            displayAlertMessage("All Fields Are Required.")
            return
        }
        
        //passwords do no match, display alert
        if(rUPassword != rRPassword)
        {
            displayAlertMessage("Passwords Do Not Match.")
            return
        }
        
        //checks information in the API
        RestApiManager.sharedInstance.confirmRegister(String(rCIN)){ json -> Void in
            let empty = json.isEmpty
            
            //if data is returned, parse through it
            if (!empty)
            {
                //confirms first name, last name, and CIN are located in the api
                // ** meant to confirm that the user is a student in the class **
                for (_,usr) in json
                {
                    if(String(usr["fName"]) == rFName && rLName == String(usr["lName"]) && rCIN == String(usr["cin"]))
                    {
                        check =  true;
                        rID = String(usr["id"])
                        print(rID)
                    }
                    else
                    {
                        self.displayAlertMessage("The First Name, Last Name, or CIN does not match student.")
                        return
                    }
                }
                
                //will continue if name and cin are located in database
                if(check)
                {
                    let myURL = "http://localhost:1337/user/update/\(rID)?"
                    _ = "/update/"+rID+"?username="+rUsername+"&password="+rUPassword
                    let parameters = ["username": rUsername, "password": rUPassword]
                    
                    //post request will create the user and input username/password into database
                    Alamofire.request(.POST, myURL, parameters: parameters)
                        .response { request, response, data, error in
                            print("Response_-------\(response!.statusCode)")
                            
                            if(response!.statusCode == 200)
                            {
                                let alert = UIAlertController(title: "Congratulations!", message: "You have been registered!", preferredStyle: UIAlertControllerStyle.Alert)
                                
                                let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default)
                                    {
                                        action in self.dismissViewControllerAnimated(true, completion: nil)
                                }
                                
                                alert.addAction(okButton)
                                self.presentViewController(alert, animated: true, completion: nil)
                            }
                            else
                            {
                                self.displayAlertMessage("The username is already taken")
                            }
                    }
                    
                    
                    
                }
            }
            else
            {
                dispatch_async(dispatch_get_main_queue()) {
                    self.displayAlertMessage("CIN is not found in the class roster")                    
                }
            }
        }
    }
    
    //changes display to login menu.
    @IBAction func Login(sender: AnyObject) {
        
        self.performSegueWithIdentifier("toLogin", sender: self)
    }
    
    
    //displays alert with a certain message.
    func displayAlertMessage(uMessage: String)
    {
        let myAlert = UIAlertController(title:"Alert", message: uMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okButton)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
}