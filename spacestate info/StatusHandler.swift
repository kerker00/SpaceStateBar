//
//  StatusHandler.swift
//  MainFrameStatusBar
//
//  Created by markus on 05.08.14.
//  Copyright (c) 2014 grafixmafia.net. All rights reserved.
//

import Foundation

public class StatusHandler {
    
    init() {
        
    }
    
    public var stateDetails: NSDictionary?
    
    public var status: NSString? {
        get {
            return self.getStatus()
        }
    }
    
    func getStatus() -> NSString {
        var freshStatus: NSString = ""
        
        let urlPath: String = "http://status.kreativitaet-trifft-technik.de/api/openState"
        var url: NSURL = NSURL(string: urlPath)!
        var request1: NSURLRequest = NSURLRequest(URL: url)
        
        var response: NSURLResponse?
        var error: NSError?
        
        var dataVal: NSData?
        
        dataVal =  NSURLConnection.sendSynchronousRequest(request1, returningResponse: &response, error: &error)
        
        if let myError = error {
            freshStatus = "X"
        } else {
            var err: NSError
            
            var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataVal!, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            
            if(jsonResult.valueForKey("state") as! NSString == "off") {
                freshStatus = "C"
            } else {
                freshStatus = "O"
            }
            
        }
        return freshStatus
    }
    
    func getDetails(urlToSpace : NSString) {
        var freshDetails : NSDictionary = NSDictionary()
        
        // var urlPathToSpace: String = "http://status.mainframe.io/api/spaceInfo"
        var url: NSURL = NSURL(string: urlToSpace as String)!
        var request1: NSURLRequest = NSURLRequest(URL: url)
        let queue:NSOperationQueue = NSOperationQueue()
        
        var stateDetails : NSDictionary = NSDictionary()
        NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var err: NSError?
            
            if let myerror : NSError = error {
                self.stateDetails = NSDictionary()
            } else {
                self.stateDetails = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary
                println("Status")
                // println(freshDetails)
            }
        })
    }
}