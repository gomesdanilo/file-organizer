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
    
    var newFilePath : String?
    var success : Bool
    
    init(filePath:String, timestamp:NSDate)
    {
        self.filePath = filePath
        self.timestamp = timestamp
        self.success = false
    }
    
    var description: String {
        
        return String(format: "[%@] Old Filepath %@ New Filepath %@",
            (self.success ? "SUCCESS":"ERROR  "),
            self.filePath,
            (self.newFilePath != nil ? self.newFilePath! : "--"))
    }
}