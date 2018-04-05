//
//  User.swift
//  leaf
//
//  Created by Carl Bolstad on 2/6/18.
//  Copyright © 2018 Carl Bolstad. All rights reserved.
//

import Foundation

struct User {
   var firstName: String?
   var lastName: String?
   var email: String
   var leafs: [Leaf]? = [Leaf]()
}
