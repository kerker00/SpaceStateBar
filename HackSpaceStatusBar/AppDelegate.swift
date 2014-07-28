//
//  AppDelegate.swift
//  HackSpaceStatusBar
//
//  Created by markus on 26.07.14.
//  Copyright (c) 2014 grafixmafia.net. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
                            
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var menu: NSMenu!
    @IBOutlet weak var prefs: NSWindow!
    @IBOutlet weak var about: NSWindow!
    @IBOutlet weak var logo: NSImageView!
    
    var statusItem: NSStatusItem!
    var timer : NSTimer? = nil
    
    override func awakeFromNib()  {
        var myInt = NSInteger(NSVariableStatusItemLength)
        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(CGFloat(myInt))
        statusItem.setMenu(menu)

        statusItem.setHighlightMode(true)
        
        self.getStatus()
        
        self.getDetails()
        
    }
    
    @IBAction func showDetails(sender: AnyObject) {
        NSApp.activateIgnoringOtherApps(true)
        window.makeKeyAndOrderFront(nil)
    }
    @IBAction func quit(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(nil)
    }
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        if timer {
            timer!.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(120.0, repeats: true) {
            self.getStatus()
        }
    }

    @IBAction func aboutScreen(sender: AnyObject) {
        NSApp.activateIgnoringOtherApps(true)
        window.makeKeyAndOrderFront(nil)
    }
    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }

    
    @IBAction func showAboutView(sender: AnyObject) {
        NSApp.activateIgnoringOtherApps(true)
        about.makeKeyAndOrderFront(nil)
    }
    
    @IBAction func showPrefView(sender: AnyObject) {
        NSApp.activateIgnoringOtherApps(true)
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
    
    
    @IBAction func refreshStatus(sender: AnyObject) {
        self.getStatus()
    }
    
    func getStatus() {
        if let myAnswer = self.getJSON("http://status.kreativitaet-trifft-technik.de/api/openState") {
            if(self.parseJSON(myAnswer).valueForKey("state") as NSString == "off") {
                self.statusItem.setTitle("C")
                println("Closed")
            } else {
                self.statusItem.setTitle("O")
                println("Open")
            }
            
        } else {
            self.statusItem.setTitle("X")
            println("Unknown")
        }
    }
}

