//
//  StatusHandler.swift
//  MainFrameStatusBar
//
//  Created by markus on 05.08.14.
//  Copyright (c) 2014 grafixmafia.net. All rights reserved.
//

import Foundation

public class StatusHandler {
    
    public var status: NSString? {
        get {
            return self.getStatus()
        }
    }
    
    func getStatus() -> NSString {
        var freshStatus: NSString = ""
        
        let urlPath: String = "http://status.kreativitaet-trifft-technik.de/api/openState"
        var url: NSURL = NSURL(string: urlPath)
        var request1: NSURLRequest = NSURLRequest(URL: url)

        var response: NSURLResponse?
        var error: NSError?
        
        var dataVal: NSData?
        
        dataVal =  NSURLConnection.sendSynchronousRequest(request1, returningResponse: &response, error: &error)
        
        if let myError = error {
            freshStatus = "X"
        } else {
            var err: NSError
            
            var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary

            if(jsonResult.valueForKey("state") as NSString == "off") {
                freshStatus = "C"
            } else {
                freshStatus = "O"
            }
 
        }
        
            
        
        return freshStatus
    }
}