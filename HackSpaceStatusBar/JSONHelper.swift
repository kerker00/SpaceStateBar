//
//  JSONHelper.swift
//  MainFrameStatusBar
//
//  Created by markus on 10.08.14.
//  Copyright (c) 2014 grafixmafia.net. All rights reserved.
//

import Foundation

public class JSONHelper {
    public func getJSON(urlToRequest: String) -> NSData?{
        return NSData(contentsOfURL: NSURL(string: urlToRequest))
    }
    
    public func parseJSON(inputData: NSData) -> NSDictionary{
        var error: NSError?
        var boardsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        
        return boardsDictionary
    }
}

