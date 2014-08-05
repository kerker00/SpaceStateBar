//
//  PreferencePane.swift
//  MainFrameStatusBar
//
//  Created by markus on 27.07.14.
//  Copyright (c) 2014 grafixmafia.net. All rights reserved.
//

import Cocoa

class PreferencePane: NSWindow {

    @IBOutlet weak var prefView: NSView!
    
    @IBAction func startAtLogin(sender: AnyObject) {
        
    }
    
    @IBAction func showHideDockIcon(sender: AnyObject) {
        
    }
    
    @IBAction func setRequestTimerInterval(sender: AnyObject) {
        
    }
    
    @IBAction func restartMainFrameStatusBar(sender: AnyObject) {
        var task = NSTask()
        
        var args: NSMutableArray
        args = NSMutableArray()
        args.addObject("-c")
        args.addObject("sleep 0.2; open \"\(NSBundle.mainBundle().bundlePath)\"")
        
        task.launchPath = "/bin/sh"
        task.arguments = args
        task.launch()
        NSApplication.sharedApplication().terminate(nil)
    }
    
    func saveSettings() {
        
    }
    
}
