//
//  AppReducers.swift
//  leaf
//
//  Created by Carl Bolstad on 2/6/18.
//  Copyright © 2018 Carl Bolstad. All rights reserved.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
   var state = state ?? AppState()

   switch action {
   case is ActionLogin:
      let loginAction = action as! ActionLogin
      state.authenticated = true
      state.user = loginAction.user
   case is ActionLogout:
      state.authenticated = false
   default: break
   }

   return state
}
