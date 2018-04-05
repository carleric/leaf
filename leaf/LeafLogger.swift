//
//  Logger.swift
//  Leaf
//
//  Created by Carl Bolstad on 4/4/18.
//  Copyright © 2018 Carl Bolstad. All rights reserved.
//

import STLogging

class LeafLogger: LoggerProtocol {
   private var stLogger = Logger()
   
   func log(_ message: String) {
      self.stLogger.log(message)
   }
}

