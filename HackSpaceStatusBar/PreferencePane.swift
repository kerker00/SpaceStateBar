//
//  PreferencePane.swift
//  MainFrameStatusBar
//
//  Created by markus on 27.07.14.
//  Copyright (c) 2014 grafixmafia.net. All rights reserved.
//

import Cocoa
import ApplicationServices

class PreferencePane: NSWindow {

    
    
    @IBOutlet weak var prefView: NSView!
   
    
    
    func setDefaultSettings(settings: NSDictionary) {
        
    }
    
    @IBAction func startAtLogin(sender: AnyObject) {
   
    }
    
    @IBAction func setHackSpaceApiEndPoint(sender: AnyObject) {
        
    }
    
    @IBAction func showHideDockIcon(sender: AnyObject) {
        var showDockIcon = sender as NSButton
        if(showDockIcon.state == NSOnState){
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "showDockIcon")
        } else {
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "showDockIcon")
        }
        println(NSUserDefaults.standardUserDefaults().boolForKey("showDockIcon"))
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
