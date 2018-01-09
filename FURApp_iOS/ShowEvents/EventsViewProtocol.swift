//
//  EventsViewProtocol.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 1/8/18.
//  Copyright © 2018 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation

protocol EventsViewProtocol {
    func display(data: [EventsViewData]?)
    func displayNoNetwork()
    
    func showSignUpButton()
    func showSignIn(controller: Any)
    func hideSignUpButton()
    func showGoodbyeMessage()
}
