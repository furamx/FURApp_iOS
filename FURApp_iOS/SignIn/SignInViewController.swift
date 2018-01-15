//
//  SignInViewController.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 1/10/18.
//  Copyright © 2018 Fundación Rescate Arboreo. All rights reserved.
//

import UIKit
import FirebaseAuthUI
import FacebookCore
import FacebookLogin

class SignInViewController: UIViewController, SignInProtocol, FUIAuthDelegate {

    // MARK: - Properties
    var presenter: SignInPresenter!
    
    // MARK: - IBOutlets
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var emailLoginButton: UIButton!
    
    // MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.attach(view: self)
        presenter.load()
    }
    
    // MARK: - IBActions
    @IBAction func cancelSignIn(_ sender: Any) {
        hideController()
    }

    @IBAction func showEmailSignIn(_ sender: Any) {
        self.presenter.showEmailSignIn()
    }
    
    @IBAction func showFacebookSignIn(_ sender: Any) {
        presenter.facebookButtonClicked()
    }
    
    
    // MARK: - Presenter Responses
    func startLoading() {
        facebookLoginButton.isEnabled = false
        emailLoginButton.isEnabled = false
        loadingView.isHidden = false
    }
    
    func stopLoading() {
        facebookLoginButton.isEnabled = true
        emailLoginButton.isEnabled = true
        loadingView.isHidden = true
    }
    func showEmailSignIn(controller: Any) {
        present(controller as! UIViewController, animated: true, completion: nil)
    }
    
    func successfulSignIn() {
        hideController()
    }
    
    func errorSignIn(withMessage message: String) {
        let alert = UIAlertController(title: "Algo salió mal", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    func hideController() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Firebase Delegate
    // The presenter can't be the delegate because it depends on a UIViewController to show the interface
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        guard let authError = error else {
            hideController()
            return
        }
        
        let errorCode = UInt((authError as NSError).code)
        
        switch errorCode {
        case FUIAuthErrorCode.userCancelledSignIn.rawValue:
            stopLoading()
            print("User cancelled sign-in");
            break
            
        default:
            let detailedError = (authError as NSError).userInfo[NSUnderlyingErrorKey] ?? authError
            print("Login error: \((detailedError as! NSError).localizedDescription)");
        }
    }
}
