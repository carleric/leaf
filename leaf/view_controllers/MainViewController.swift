//
//  ViewController.swift
//  leaf
//
//  Created by Carl Bolstad on 2/6/18.
//  Copyright © 2018 Carl Bolstad. All rights reserved.
//

import UIKit
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import GoogleSignIn
import ReSwift

class MainViewController: UIViewController, StoreSubscriber {

   typealias StoreSubscriberStateType = AppState

   var logger = Services.makeLogger()

   lazy var authStateLabel: UILabel = {
      let label = UILabel(frame: CGRect(x: 100, y: 60, width: 300, height: 40))
      return label
   }()

   lazy var loginButton: UIButton = {
      let loginButton = UIButton()
      loginButton.frame = CGRect(x: 100, y: 100, width: 300, height: 40)
      loginButton.setTitle("login with Google", for: .normal)
      loginButton.setTitleColor(UIColor.black, for: .normal)
      loginButton.backgroundColor = UIColor.lightGray
      loginButton.layer.cornerRadius = 5.0
      loginButton.addTarget(self, action: #selector(doLogin), for: .touchUpInside)
      return loginButton
   }()

   override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = UIColor.white
      self.view.addSubview(self.authStateLabel)
      self.view.addSubview(self.loginButton)
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }

   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      mainStore.subscribe(self)
   }

   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      mainStore.unsubscribe(self)
   }

   @objc func doLogin() {
      if let googleProvider = FUIAuth.defaultAuthUI()?.providers.first as? FUIGoogleAuth {
         if mainStore.state.authenticated {
            googleProvider.signOut()
            mainStore.dispatch(ActionLogout())
         } else {
            googleProvider.signIn(withDefaultValue: nil, presenting: self, completion: { (cred, error, callback) in
               //
               if let error = error {
                  self.logger.log(error.localizedDescription)
                  callback?(nil, error)
               } else if let cred = cred {
                  NSLog("got creds from provider")
                  Auth.auth().signInAndRetrieveData(with: cred, completion: { (authDataResult, err) in
                     if let err = err {
                        self.logger.log(err.localizedDescription)
                        callback?(nil, err)
                     } else if let user = authDataResult?.user {
                        self.logger.log("got user info: \(String(describing: user.displayName))")
                        callback?(user, nil)
                        let names = user.displayName?.components(separatedBy: CharacterSet.whitespacesAndNewlines)
                        if let email = user.email {
                           let leafUser = User(firstName: names?.first, lastName: names?.last, email: email, leafs: nil)
                           mainStore.dispatch(ActionLogin(leafUser))
                        } else {
                          self.logger.log("missing email from Google user account")
                        }
                     }
                  })
               }
            })
         }
      }
   }

   func newState(state: AppState) {
      self.logger.log("state = \(state)")
      self.authStateLabel.text = "Authenticated: \(state.authenticated) User: \(String(describing: state.user?.firstName))"
      let loginButtonTitle = state.authenticated ? "logout from Google" : "login with Google"
      self.loginButton.setTitle(loginButtonTitle, for: .normal)
   }
}
