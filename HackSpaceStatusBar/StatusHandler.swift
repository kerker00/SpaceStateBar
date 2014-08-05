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
        
        if let myAnswer = self.getJSON("http://status.kreativitaet-trifft-technik.de/api/openState") {
            if(self.parseJSON(myAnswer).valueForKey("state") as NSString == "off") {
                freshStatus = "C"
            } else {
                freshStatus = "O"
            }
            
        } else {
            freshStatus = "X"
        }
        return freshStatus
    }

    func getJSON(urlToRequest: String) -> NSData?{
        return NSData(contentsOfURL: NSURL(string: urlToRequest))
    }
    
    func parseJSON(inputData: NSData) -> NSDictionary{
        var error: NSError?
        var boardsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        
        return boardsDictionary
    }
    
    
}