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
    
    @IBOutlet weak var listOfSpaces: NSPopUpButton!
    
    var spaceList : NSDictionary = NSDictionary()
    
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
        var seletedSpace = (sender as NSPopUpButton).selectedItem
        var test = NSApplication.sharedApplication().delegate as AppDelegate;
        var state = test.state
        state.setValue(spaceList.valueForKey(seletedSpace.title), forKey : "website")
    }
    
    @IBAction func showHideDockIcon(sender: AnyObject) {
        var showDockIcon = sender as NSButton
        if(showDockIcon.state == NSOnState){
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "showDockIcon")
        } else {
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "showDockIcon")
        }
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
    
    func getListofSpaces() {
        
        let urlPath: String = "http://spaceapi.net/directory.json?api=0.13"
        var url: NSURL = NSURL(string: urlPath)
        var request1: NSURLRequest = NSURLRequest(URL: url)
        let queue:NSOperationQueue = NSOperationQueue()
        
        
        NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            /* Your code */
            
            var err: NSError?
            
            if let myerror : NSError = error {
                self.setListOfSpaces(NSDictionary())
            } else {
                var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
                self.setListOfSpaces(jsonResult)
                self.spaceList = jsonResult
            }
        })
        
    }
    
    func setListOfSpaces(spaceList: NSDictionary) {
        listOfSpaces.removeAllItems()
        var myItems = spaceList.allKeys as NSArray
        var sortedItems = myItems.sortedArrayUsingSelector("compare:")
        listOfSpaces.addItemsWithTitles(sortedItems)
    }
}
