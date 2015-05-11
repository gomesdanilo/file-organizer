//
//  main.swift
//  fileorganizer
//
//  Created by Danilo Gomes on 11/05/2015.
//  Copyright (c) 2015 Danilo Gomes. All rights reserved.
//

import Foundation


func main(){

    if(Process.argc != 3)
    {
        showMessage("Invalid parameters. Please provide a valid path.")
        showMessage("<INPUT> <OUTPUT>")
        return
    }
    
    var input : String? = String.fromCString(Process.unsafeArgv[1])
    var output : String? = String.fromCString(Process.unsafeArgv[2])
    
    let fileManager = FileManager(inputPath: input!, outputPath: output!)
    fileManager.execute()
}

func showMessage(msg : String)
{
    println("%@", msg);
}


main()