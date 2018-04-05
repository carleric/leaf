//
//  AuthActions.swift
//  leaf
//
//  Created by Carl Bolstad on 2/6/18.
//  Copyright © 2018 Carl Bolstad. All rights reserved.
//

import Foundation
import ReSwift

struct ActionLogin: Action {
   public var user: User
   init(_ user: User) {
      self.user = user 
   }
}
struct ActionLogout: Action {}
