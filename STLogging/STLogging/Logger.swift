//
//  Logger.swift
//  STLogging
//
//  Created by Carl Bolstad on 4/4/18.
//  Copyright © 2018 Carl Bolstad. All rights reserved.
//

public protocol LoggingProtocol {
   func log(_ message: String)
}

public class Logger: LoggingProtocol {
   public init() {
      
   }
   
   public func log(_ message: String) {
      NSLog(message)
   }
}
