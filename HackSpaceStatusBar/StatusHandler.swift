//
//  StatusHandler.swift
//  MainFrameStatusBar
//
//  Created by markus on 05.08.14.
//  Copyright (c) 2014 grafixmafia.net. All rights reserved.
//

import Foundation

public class StatusHandler {
 
    var jsonTool : JSONHelper = JSONHelper()
    
    public var status: NSString? {
        get {
            return self.getStatus()
        }
    }
    
    func getStatus() -> NSString {
        var freshStatus: NSString = ""
        
        if let myAnswer = jsonTool.getJSON("http://status.kreativitaet-trifft-technik.de/api/openState") {
            if(jsonTool.parseJSON(myAnswer).valueForKey("state") as NSString == "off") {
                freshStatus = "C"
            } else {
                freshStatus = "O"
            }
            
        } else {
            freshStatus = "X"
        }
        return freshStatus
    }
}