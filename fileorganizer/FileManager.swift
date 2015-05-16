//
//  FileManager.swift
//  fileorganizer
//
//  Created by Danilo Gomes on 11/05/2015.
//  Copyright (c) 2015 Danilo Gomes. All rights reserved.
//

import Foundation

/**
    Manages all file interaction, moving files from the input folder to the
    output folder putting all files in the proper folder using timestamps.
*/
class FileManager {
    
    let inputPath : String
    let outputPath : String
    
    
    // MARK: Constructor
    
    init (inputPath:String, outputPath:String) {
        
        self.inputPath = inputPath;
        self.outputPath = outputPath;
    }
    
    // MARK: Entry point
    
    func execute () {
        
        // Counters - Success
        var count : Int = 0
        var success : Int = 0
        var error : Int = 0
        
        // Managers.
        let reader = HierarchyReader(inputPath: self.inputPath)
        let writer = HierarchyWriter(outputPath: self.outputPath)
        
        while let entry = reader.nextObject()
        {
            if(writer.write(entry))
            {
                success++;
            }
            else
            {
                error++
            }
            
            count++
        }
        
        // TODO: Present results.
    }
    
}
