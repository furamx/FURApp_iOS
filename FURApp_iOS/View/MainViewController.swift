//
//  ViewController.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/7/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseFacebookAuthUI


class MainViewController: UIViewController {
    
    fileprivate(set) var authUI: FUIAuth?

    override func viewDidLoad() {
        // This is for the login button to appear everytime the app is launched.
        // Delete this further in the development
        do{
            try Auth.auth().signOut()
            print("User signed out")
        }catch {
            print("There is no user")
        }
        // end of comment
        
        super.viewDidLoad()
        
        self.authUI = FUIAuth.defaultAuthUI()
        self.authUI?.delegate = (AuthViewController() as FUIAuthDelegate)
        self.authUI?.providers = [FUIFacebookAuth()]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Button Actions
    @IBAction func openLoginAction(_ sender: UIButton) {
        // TODO: Hacer un fork en el repositorio de firebase para cambiar NSBundle.mainBundle a Bundle.main
        authUI?.customStringsBundle = Bundle.main
        let authViewController = authUI?.authViewController()
        self.present(authViewController!, animated: true, completion: nil)
    }
}

