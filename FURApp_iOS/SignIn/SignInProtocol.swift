//
//  SignInProtocol.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 1/10/18.
//  Copyright © 2018 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation

protocol SignInProtocol {
    
    // MARK: - Presenter Responses
    func startLoading()
    func stopLoading()
    func showEmailSignIn(controller: Any)
    func successfulSignIn()
    func errorSignIn(withMessage: String)
    
}
