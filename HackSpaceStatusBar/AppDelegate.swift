//
//  AppDelegate.swift
//  HackSpaceStatusBar
//
//  Created by markus on 26.07.14.
//  Copyright (c) 2014 grafixmafia.net. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
                            
  
    @IBOutlet weak var menu: NSMenu!
    @IBOutlet weak var prefs: NSWindow!
    @IBOutlet weak var about: NSWindow!
    
    
    @IBOutlet weak var details: StatusDetails!
    
    var statusItem: NSStatusItem!
    var timer : NSTimer = NSTimer()
    
    var mainFrameStatus : StatusHandler?
    
    override func awakeFromNib()  {
       //  var myInt = NSInteger(NSVariableStatusItemLength)
        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(CGFloat(-2))

        statusItem.menu = menu
            // setMenu(menu)

        statusItem.highlightMode = true
        
        mainFrameStatus = StatusHandler()
        
        statusItem.title = mainFrameStatus?.status        
    }
    
    @IBAction func quit(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(nil)
    }
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        
        if timer.valid {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(120.0, repeats: true) {
             self.statusItem.title = self.mainFrameStatus?.status
        }
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }

    @IBAction func showDetailsView(sender: AnyObject) {
        NSApp.activateIgnoringOtherApps(true)
        details.center()
        details.makeKeyAndOrderFront(nil)
    }
    
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
    
    @IBAction func refresh(sender: AnyObject) {
        self.statusItem.title = self.mainFrameStatus?.status
    }
}

