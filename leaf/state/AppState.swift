//
//  AppState.swift
//  leaf
//
//  Created by Carl Bolstad on 2/6/18.
//  Copyright © 2018 Carl Bolstad. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
   var counter: Int = 0
   var authenticated: Bool = false
}
