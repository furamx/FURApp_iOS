//
//  SignInPresenter.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 1/10/18.
//  Copyright © 2018 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation
import FirebaseAuthUI
import FirebaseAuth
import FirebaseFacebookAuthUI
import FacebookLogin
import FacebookCore

class SignInPresenter {
    
    // MARK: - Properties
    var view: SignInProtocol?
    fileprivate(set) var authUI: FUIAuth?
    
    init() {}
    
    func attach(view: SignInProtocol) {
        self.view = view
    }
    
    func dettachView() {
        self.view = nil
    }
    
    func load() {
        self.setupAuth()
    }
    
    func setupAuth() {
        self.authUI = FUIAuth.defaultAuthUI()
        self.authUI?.delegate = view as? FUIAuthDelegate
    }
    
    // MARK: - View actions
    func showEmailSignIn() {
        authUI?.customStringsBundle = Bundle.main
        self.view?.showEmailSignIn(controller: authUI?.authViewController() as Any)
    }
    
    @objc func facebookButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(publishPermissions: [.rsvpEvent], viewController: view as? UIViewController, completion: self.facebookLogin(result:))
    }
    
    // MARK: - Login Result
    
    func facebookLogin(result: LoginResult) {
        switch result {
        case .success(grantedPermissions: _, declinedPermissions: let declinedPermissions, token: let token):
            guard !declinedPermissions.contains(Permission(name: "rsvp_event")) else {
            break
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: token.authenticationToken)
            Auth.auth().signIn(with: credential) { (user, error) in
                self.view?.hideController()
            }
            break
        default:
            break
        }
    }
}
