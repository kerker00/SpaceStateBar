//
//  TodayViewController.swift
//  ncspacestatet
//
//  Created by markus on 26.01.15.
//  Copyright (c) 2015 grafixmafia.net. All rights reserved.
//

import Cocoa
import NotificationCenter

class TodayViewController: NSViewController, NCWidgetProviding {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var Hallo: NSTextField!
    
    
    var statusHandler : StatusHandler
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusHandler = StatusHandler()
        
        let statusString : NSString = statusHandler.getStatus()
        Hallo.stringValue = statusString as String
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.NewData)
    }
    
}
