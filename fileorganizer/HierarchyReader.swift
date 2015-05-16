//
//  HierarchyReader.swift
//  fileorganizer
//
//  Created by Danilo Gomes on 16/05/2015.
//  Copyright (c) 2015 Danilo Gomes. All rights reserved.
//

import Foundation

class HierarchyReader
{
    let inputPath : String
    let fileManager = NSFileManager.defaultManager()
    
    var enumerator : NSDirectoryEnumerator?
    
    // MARK: Constructor
    
    init (inputPath : String){
        self.inputPath = inputPath;
        
        // Retrieve enumerator for all files in input folder hierarchy.
        let urlInputFolder : NSURL = NSURL(fileURLWithPath: self.inputPath)!
        let properties : [AnyObject]? = [NSURLIsDirectoryKey, NSURLCreationDateKey]

        self.enumerator = fileManager.enumeratorAtURL(urlInputFolder,
                                                      includingPropertiesForKeys: properties,
                                                      options: NSDirectoryEnumerationOptions(), errorHandler: nil)
        
    }
 
    // MARK: Iterator
    
    func nextObject() -> HierarchyEntry? {
    
        // Validation
        if(self.enumerator == nil)
        {
            return nil
        }
        
        // Searches first valid file.
        while let currentFile = enumerator?.nextObject() as? NSURL {
            
            let currentPath : String = currentFile.path!
            
            var error : NSError?
            var isDirectoryObj : AnyObject?
            var creationDateObj : AnyObject?
            
            var success = true
            
            success = (success && currentFile.getResourceValue(&isDirectoryObj, forKey:NSURLIsDirectoryKey, error:&error))
            success = (success && currentFile.getResourceValue(&creationDateObj, forKey:NSURLCreationDateKey, error:&error))
            
            if(success)
            {
                let isDirectory = (isDirectoryObj as! NSNumber).boolValue
                let creationDate = (creationDateObj as! NSDate)
                
                if(!isDirectory)
                {
                    let entry = HierarchyEntry(filePath:currentPath, timestamp:creationDate)
                    return entry
                }
            }
        }
        
        return nil
        
    }
}
