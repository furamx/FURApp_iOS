//
//  AuthViewDelegate.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/9/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//
// This file serves as a delegate for the FirebaseUI Authentication system
// This gets called from MainViewController

import UIKit
import Firebase
import FirebaseAuthUI

class AuthViewController: UIViewController, FUIAuthDelegate {
    
    fileprivate(set) var auth: Auth?
    fileprivate(set) var authUI: FUIAuth? //only set internally but get externally
    fileprivate(set) var authStateListenerHandle: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.auth = Auth.auth()

        //        self.authStateListenerHandle = self.auth?.addStateDidChangeListener { (auth, user) in
        //            guard user != nil else {
        //                self.loginAction(sender: self)
        //                return
        //            }
        //        }
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        guard let authError = error else { return }
        
        let errorCode = UInt((authError as NSError).code)
        
        switch errorCode {
        case FUIAuthErrorCode.userCancelledSignIn.rawValue:
            print("User cancelled sign-in");
            break
            
        default:
            let detailedError = (authError as NSError).userInfo[NSUnderlyingErrorKey] ?? authError
            print("Login error: \((detailedError as! NSError).localizedDescription)");
        }
    }
}
