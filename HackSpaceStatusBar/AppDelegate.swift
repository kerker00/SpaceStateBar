//
//  AppDelegate.swift
//  HackSpaceStatusBar
//
//  Created by markus on 26.07.14.
//  Copyright (c) 2014 grafixmafia.net. All rights reserved.
//

import Cocoa
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
                            
  
    @IBOutlet weak var menu: NSMenu!
    @IBOutlet weak var prefs: NSWindow!
    @IBOutlet weak var about: NSWindow!
    
    
    var statusItem: NSStatusItem!
    var timer : NSTimer = NSTimer()
    
    override func awakeFromNib()  {
       //  var myInt = NSInteger(NSVariableStatusItemLength)
        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(CGFloat(-2))

        statusItem.menu = menu
            // setMenu(menu)

        statusItem.highlightMode = true
        
        self.getStatus()
        
        self.getDetails()
        
    }
    
    @IBAction func quit(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(nil)
    }
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        
        if timer.valid {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(120.0, repeats: true) {
            self.getStatus()
        }
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }

//    @IBAction func showDetailsView(sender: AnyObject) {
//        NSApp.activateIgnoringOtherApps(true)
//        details.makeKeyAndOrderFront(nil)
//    }
    
    @IBAction func showAboutView(sender: AnyObject) {
        NSApp.activateIgnoringOtherApps(true)
        about.center()
        about.makeKeyAndOrderFront(nil)
    }
    
    @IBAction func showPrefView(sender: AnyObject) {
        NSApp.activateIgnoringOtherApps(true)
        prefs.center()
        prefs.makeKeyAndOrderFront(nil)
    }
    
    func getJSON(urlToRequest: String) -> NSData?{
        return NSData(contentsOfURL: NSURL(string: urlToRequest))
    }
    
    func parseJSON(inputData: NSData) -> NSDictionary{
        var error: NSError?
        var boardsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        
        return boardsDictionary
    }
    
    func getDetails(){
        
    }
    
    func getStatus() {
        if let myAnswer = self.getJSON("http://status.kreativitaet-trifft-technik.de/api/openState") {
            if(self.parseJSON(myAnswer).valueForKey("state") as NSString == "off") {
                self.statusItem.title = "C"
                println("Closed")
            } else {
                self.statusItem.title = "O"
                println("Open")
            }
            
        } else {
            self.statusItem.title = "X"
            println("Unknown")
        }
    }
    @IBAction func restartApp(sender: AnyObject) {
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
}

