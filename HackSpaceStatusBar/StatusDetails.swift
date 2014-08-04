//
//  StatusDetails.swift
//  MainFrameStatusBar
//
//  Created by markus on 04.08.14.
//  Copyright (c) 2014 grafixmafia.net. All rights reserved.
//

import Cocoa

class StatusDetails: NSWindow {
    
    @IBOutlet weak var view: NSView!
    @IBOutlet weak var website: NSTextField!
    
    @IBAction func refreshDetails(sender: AnyObject) {
            website.setStringValue("Hello")
    }
}