//
//  RestApiManager.swift
//  LAP
//
//  Created by kevin on 12/11/15.
//  Copyright © 2015 Kevin Argumedo. All rights reserved.
//


import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager : NSObject {
    
    static let sharedInstance = RestApiManager()
    
    //edit url in register and viewSpecie as well
    let link = "localhost:1337/"
    

    
    //gets the specified user
    func getUser(let user: String, let pass: String, onCompletion: (JSON) -> Void) {
        
        let searchUser = link+"user/?username="+user+"&password="+pass
        
        makeHTTPGetRequest(searchUser, onCompletion: { json , err -> Void in
            onCompletion(json)
            print(json)
            
        })
    }
    
    //confirms user exists in API
    func confirmRegister(let cin: String, onCompletion: (JSON) -> Void)
    {
        
        let searchUser = link+"user/?cin="+cin
        
        makeHTTPGetRequest(searchUser, onCompletion: { json , err -> Void in
            onCompletion(json)
        })
    }
    

    //gets the species specified
    func getSpecies(let specie: String, onCompletion: (JSON) -> Void)
    {
        let searchSpecies = link+"trees?where=%7B%22name%22:%7B%22contains%22:%22"+specie+"%22%7D%7D"
       
        print(searchSpecies)
        makeHTTPGetRequest(searchSpecies, onCompletion: { json , err -> Void in
            onCompletion(json)
        })
        
    }
    
    //makes the HTTPRequest
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: { data, response, error in
            let json:JSON = JSON(data: data!)
            onCompletion(json, error)
        })
        task.resume()
    }
}