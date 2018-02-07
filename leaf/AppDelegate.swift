//
//  AppDelegate.swift
//  leaf
//
//  Created by Carl Bolstad on 2/6/18.
//  Copyright © 2018 Carl Bolstad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import ReSwift

let mainStore = Store<AppState>(
   reducer: appReducer,
   state: nil,
   middleware: [])

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?

   func application(_ application: UIApplication,
                    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      // Override point for customization after application launch.
      FirebaseApp.configure()

      let authUI = FUIAuth.defaultAuthUI()
      let providers: [FUIAuthProvider] = [
         FUIGoogleAuth()
         ]
      authUI?.providers = providers

      let mainViewController = MainViewController()
      let rootNavigationController = UINavigationController(rootViewController: mainViewController)

      self.window = UIWindow(frame: UIScreen.main.bounds)
      window?.rootViewController = rootNavigationController
      window?.makeKeyAndVisible()

      return true
   }

   @available(iOS 9.0, *)
   func application(_ application: UIApplication, open url: URL,
                    options: [UIApplicationOpenURLOptionsKey: Any]) -> Bool {
      if let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String? {
         if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
         }
      }
      return false
   }

   func application(_ application: UIApplication, open url: URL, sourceApplication: String?,
                    annotation: Any) -> Bool {
      if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
         return true
      }
      return false
   }

}
