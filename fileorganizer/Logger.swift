//
//  Logger.swift
//  fileorganizer
//
//  Created by Danilo Gomes on 16/05/2015.
//  Copyright (c) 2015 Danilo Gomes. All rights reserved.
//

import Foundation

class Logger {
    
    //private let CONSOLE_RESET = "\x1B[0m"
    //private let CONSOLE_RED = "\x1B[31m"
    //private let CONSOLE_GREEN = "\x1B[32m"
    
    // TODO: Implement colors.
    
    func showMessage (message:String){
        println(message)
    }
    
    func showError (error:String){
        println(error)
    }
    
    func showSuccess (message:String){
        println(message)
    }
}