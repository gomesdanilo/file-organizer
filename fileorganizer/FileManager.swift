//
//  FileManager.swift
//  fileorganizer
//
//  Created by Danilo Gomes on 11/05/2015.
//  Copyright (c) 2015 Danilo Gomes. All rights reserved.
//

import Foundation


class FileManager {
    
    let ZERO_ORDER = 0
    
    let dateFormatter : NSDateFormatter
    let inputPath : String
    let outputPath : String
    
    
    init (inputPath:String, outputPath:String){
        
        self.dateFormatter = NSDateFormatter()
        self.dateFormatter.dateFormat = "yyyy-MM-dd HH-mm-ss"
        self.inputPath = inputPath;
        self.outputPath = outputPath;
    }
    
    
    func generateNewFilename(originalPath:String, creationDate:NSDate, order:Int) -> String
    {
        let fileExtension : String = originalPath.pathExtension
        let parentPath : String = originalPath.stringByDeletingLastPathComponent
        
        var fileName  : String?
        var timeStamp : String = self.dateFormatter.stringFromDate(creationDate)
        
        if(order > ZERO_ORDER)
        {
            fileName = String(format: "%@ (%d)", timeStamp, order)
        }
        else
        {
            fileName = timeStamp;
        }
        
        let finalName  : String = parentPath.stringByAppendingPathComponent(fileName!).stringByAppendingPathExtension(fileExtension)!
        return finalName
    }
    
    
    func execute() {
    
        var nSuccess = 0;
        var nError = 0;
        var nSkipped = 0;
    
        let fileManager = NSFileManager.defaultManager()
        
        
        // Retrieve enumerator for all files in input folder.
        let urlInputFolder : NSURL = NSURL(fileURLWithPath: self.inputPath)!
        let properties : [AnyObject]? = [NSURLIsDirectoryKey, NSURLCreationDateKey]
        
        // TODO: Use exif data.
        
        let enumerator : NSDirectoryEnumerator? = fileManager.enumeratorAtURL(
            urlInputFolder,
            includingPropertiesForKeys: properties,
            options: NSDirectoryEnumerationOptions(), errorHandler: nil)
        
        
        let stopwatch = Stopwatch();
    
        stopwatch.start()
        
        while let currentFile = enumerator?.nextObject() as? NSURL {
            let currentPath : String = currentFile.path!
            
            var error : NSError?
            var isDirectory : AnyObject?
            var creationDate : AnyObject?
            
            var success = true
            
            
            if(success && currentFile.getResourceValue(&isDirectory, forKey:NSURLIsDirectoryKey, error:&error))
            {
                
            }
            else
            {
    
            }
            
            if(success && currentFile.getResourceValue(&creationDate, forKey:NSURLCreationDateKey, error:&error))
            {

            }
            else
            {
    
            }
            
            
            
            if(success && !(isDirectory as! NSNumber).boolValue)
            {
                var order = ZERO_ORDER
                
                var newPath : String = self.generateNewFilename(currentPath, creationDate: (creationDate as! NSDate), order: order)
                
                
                if(!(currentPath == newPath))
                {
                    while (fileManager.fileExistsAtPath(newPath)) {
                        order++;
                        
                        newPath = self.generateNewFilename(currentPath, creationDate: (creationDate as! NSDate), order: order)
                    }

                    success = fileManager.moveItemAtPath(currentPath, toPath: newPath, error: &error)

                    if(success)
                    {
                        //[self showMessage:[NSString stringWithFormat:@"Renamed to > %@", newPath]];
                        nSuccess++;
                    }
                    else
                    {
                        nError++;
                    }
                }
                else
                {
                    //[self showMessage:[NSString stringWithFormat:@"Skipped > %@", newPath]];
                    nSkipped++;
                }
            }
            
        }
        
        stopwatch.stop()
        
        //[self showSuccess:[NSString stringWithFormat:@"Results %d Success %d Error %d Skipped", nSuccess, nError, nSkipped]];
        //[self showSuccess:[NSString stringWithFormat:@"Time elapsed %@", [stopwatch print]]];
        //[self showMessage:@"."];
    }
    
}



//#import <Foundation/Foundation.h>
//
//@interface Renamer : NSObject
//
//-(void)executeWithRootPath:(NSString*)path;
//
//@end

//#import "Renamer.h"
//#import "Stopwatch.h"
//
//#define ZERO_ORDER 0
//
//#define CONSOLE_RESET   "\x1B[0m"
//#define CONSOLE_RED     "\x1B[31m"
//#define CONSOLE_GREEN   "\x1B[32m"
//#define CONSOLE_YELLOW  "\x1B[33m"
//#define CONSOLE_BLUE    "\x1B[34m"
//#define CONSOLE_MAGENTA "\x1B[35m"
//#define CONSOLE_CYAN    "\x1B[36m"
//#define CONSOLE_WHYTE   "\x1B[37m"
//
//@interface Renamer()
//{
//    NSDateFormatter *dateFormatter;
//}
//@end
//
//@implementation Renamer


//
//-(void)showMessage:(NSString *)msg
//{
//    if(msg != nil)
//    {
//        printf(CONSOLE_RESET "%s\n", [msg UTF8String]);
//    }
//}
//
//-(void)showError:(NSString *)msg
//{
//    if(msg != nil)
//    {
//        printf(CONSOLE_RED "%s\n", [msg UTF8String]);
//    }
//}
//
//-(void)showSuccess:(NSString *)msg
//{
//    if(msg != nil)
//    {
//        printf(CONSOLE_GREEN "%s\n", [msg UTF8String]);
//    }
//}
//

//
