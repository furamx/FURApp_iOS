//
//  SignInPresenter.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 1/10/18.
//  Copyright © 2018 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation
import FirebaseAuthUI


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
    
    func showEmailSignIn() {
        authUI?.customStringsBundle = Bundle.main
        self.view?.showEmailSignIn(controller: authUI?.authViewController() as Any)
    }
}
