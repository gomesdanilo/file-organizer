//
//  HierarchyEntry.swift
//  fileorganizer
//
//  Created by Danilo Gomes on 16/05/2015.
//  Copyright (c) 2015 Danilo Gomes. All rights reserved.
//

import Foundation

class HierarchyEntry : Printable
{
    let filePath : String
    let timestamp : NSDate
    
    init(filePath:String, timestamp:NSDate)
    {
        self.filePath = filePath
        self.timestamp = timestamp
    }
    
    var description: String {
        return String("\(self.filePath) \(self.timestamp)")
    }
    
}