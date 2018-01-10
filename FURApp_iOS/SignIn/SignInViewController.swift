//
//  SignInViewController.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 1/10/18.
//  Copyright © 2018 Fundación Rescate Arboreo. All rights reserved.
//

import UIKit
import FirebaseAuthUI

class SignInViewController: UIViewController, SignInProtocol, FUIAuthDelegate {

    // MARK: - Properties
    var presenter: SignInPresenter!
    
    // MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.attach(view: self)
        presenter.load()
    }
    
    // MARK: - IBActions
    @IBAction func cancelSignIn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func showEmailSignIn(_ sender: Any) {
        self.presenter.showEmailSignIn()
    }
    
    // MARK: - Presenter Responses
    func showEmailSignIn(controller: Any) {
        present(controller as! UIViewController, animated: true, completion: nil)
    }
    
    // MARK: - Firebase Authentication
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        guard let authError = error else {
            dismiss(animated: true, completion: nil)
            return
        }
        
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
