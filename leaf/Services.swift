//
//  Log.swift
//  Leaf
//
//  Created by Carl Bolstad on 4/4/18.
//  Copyright © 2018 Carl Bolstad. All rights reserved.
//

protocol LoggerProtocol {
   func log(_ message: String)
}

protocol ServiceFactory {
   static func makeLogger() -> LoggerProtocol
}

class Services: ServiceFactory {
   static func makeLogger() -> LoggerProtocol {
      return LeafLogger()
   }
}
