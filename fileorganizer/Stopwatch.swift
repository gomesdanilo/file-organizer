//
//  Stopwatch.swift
//  fileorganizer
//
//  Created by Danilo Gomes on 11/05/2015.
//  Copyright (c) 2015 Danilo Gomes. All rights reserved.
//

import Foundation

class Stopwatch {

    var startValue : NSDate?
    var stopValue : NSDate?
    
    init() {
        self.startValue = nil;
        self.stopValue = nil;
    }
    
    func start() {
        self.stopValue = nil
        self.startValue = NSDate()
    }
    
    func stop() {
        self.stopValue = NSDate()
    }
    
    func print() -> NSString  {
        if(self.startValue != nil && self.stopValue != nil)
        {
            var interval : NSTimeInterval = self.stopValue!.timeIntervalSinceDate(self.startValue!)
            
            let ms      = Int((interval * 1000) % 1000)
            let seconds = Int((interval % 60))
            let minutes = Int((interval / 60) % 60)
            let hours   = Int((interval / (60*60)) % 24)
            
            let msg = NSString(format: "%02d h %02d min %02d s %02d ms", hours, minutes, seconds, ms)
            
            return msg;
        }
        else
        {
            return "Stopwatch - Please use start/stop methods."
        }
    }
}
