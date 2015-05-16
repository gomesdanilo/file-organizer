//
//  HierarchyWriter.swift
//  fileorganizer
//
//  Created by Danilo Gomes on 16/05/2015.
//  Copyright (c) 2015 Danilo Gomes. All rights reserved.
//

import Foundation

class HierarchyWriter
{
    let outputPath : String
    
    let fileDateFormatter : NSDateFormatter
    let folderDateFormatter : NSDateFormatter
    
    let fileManager = NSFileManager.defaultManager()
    
    // MARK: Constructors
    
    init (outputPath : String){
        self.outputPath = outputPath;
        
        self.folderDateFormatter = NSDateFormatter()
        self.folderDateFormatter.dateFormat = "yyyy-MM-dd"

        self.fileDateFormatter = NSDateFormatter()
        self.fileDateFormatter.dateFormat = "yyyy-MM-dd HH-mm-ss"

    }
    
    // MARK: Entrypoint
    
    func write(entry:HierarchyEntry) -> Bool
    {
        let folderPath = self.generateFolderName(entry)
        
        var status = createFolderStructure(folderPath)
        
        let newFilePath = self.generateNewFilePathWithEntry(entry, withFolderPath:folderPath)
        
        status = status && self.moveFileEntry(entry, toNewPath:newFilePath)
        
        return status
    }
    
    // MARK: Aux
    
    /**
        Creates folder in the output path using date.
    */
    func generateFolderName(entry:HierarchyEntry) -> String{
        let tmp = self.folderDateFormatter.stringFromDate(entry.timestamp)
        
        let ret = self.outputPath.stringByAppendingPathComponent(tmp)
        
        return ret
    }
    
    func createFolderStructure(path:String) -> Bool{
    
        var status : Bool = true
        
        if(!self.fileManager.fileExistsAtPath(path))
        {
            var error : NSError?
            status = self.fileManager.createDirectoryAtPath(path, withIntermediateDirectories:true, attributes:nil, error: &error)
        }
        
        return status
    }
    
    func generateNewFilePathWithEntry(entry:HierarchyEntry, withFolderPath folderPath:String) -> String
    {
        let fileExtension : String = entry.filePath.pathExtension
        let fileTimestamp : String = self.fileDateFormatter.stringFromDate(entry.timestamp)
        
        // Generates unique filename, preventing overwriting.
        var order = 1
        
        // Creates new filePath considering there is no duplicated file.
        var newFileName : String = fileTimestamp
        var newFilePath : String = folderPath
            .stringByAppendingPathComponent(newFileName)
            .stringByAppendingPathExtension(fileExtension)!
        
        // Iterates until generate valid name.
        while self.fileManager.fileExistsAtPath(newFilePath)
        {
            newFileName = String(format: "%@ (%02d)", fileTimestamp, order)
            newFilePath = folderPath
                .stringByAppendingPathComponent(newFileName)
                .stringByAppendingPathExtension(fileExtension)!
            
            order++;
        }
        
        return newFilePath
    }
    
    func moveFileEntry(entry:HierarchyEntry, toNewPath newFilePath:String) -> Bool
    {
        let fileManager = NSFileManager.defaultManager()
        
        var error : NSError?
        let status = fileManager.moveItemAtPath(entry.filePath, toPath: newFilePath, error: &error)
        
        entry.newFilePath = newFilePath
        entry.success = status
        
        return status
    }
}
