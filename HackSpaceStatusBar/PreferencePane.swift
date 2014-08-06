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
   
    @IBOutlet weak var atLogin: NSButton!
    
    @IBOutlet weak var dockIcon: NSButton!
    
    @IBOutlet weak var timerInterval: NSTextField!
    
    @IBOutlet weak var webSite: NSTextField!
    
    
    func setDefaultSettings(settings: NSDictionary) {
        if(settings.valueForKey("showDockIcon") as Bool) {
            dockIcon.state = NSOnState
        } else {
            dockIcon.state = NSOffState
        }
        
        if(settings.valueForKey("startOtLogin") as Bool) {
            atLogin.state = NSOnState
        } else {
            atLogin.state = NSOffState
        }
        
        timerInterval.stringValue = String(settings.valueForKey("requestTimer") as Int)
        webSite.stringValue = settings.valueForKey("website") as NSString
    }
    
    @IBAction func startAtLogin(sender: AnyObject) {
        var showDockIcon = sender as NSButton
        if(showDockIcon.state == NSOnState){
            dockIcon.state = NSOnState
        } else {
            dockIcon.state = NSOffState
        }
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
        
//        var id = NSBundle.mainBundle().bundleIdentifier
//        var workSpace = NSWorkspace()
//        workSpace.launchAppWithBundleIdentifier(id, options: NSWorkspaceLaunchOptions.Default | NSWorkspaceLaunchOptions.NewInstance | NSWorkspaceLaunchOptions.Async, additionalEventParamDescriptor: nil, launchIdentifier: nil)
//        
        NSApplication.sharedApplication().terminate(nil)
    }
    
    func saveSettings() {
        
    }
    
}
