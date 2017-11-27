//
//  EventsPresenter.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/20/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseFacebookAuthUI

class EventsPresenter {
    
    // MARK: - Properties
    private var eventsViewController : EventsViewController?
    private let dataManager : DataManager!
    fileprivate(set) var auth: Auth?
    fileprivate(set) var authUI: FUIAuth?
    fileprivate(set) var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    // MARK: - Initializers
    init() {
        dataManager = DataManager()
    }
    
    func attachView(view: EventsViewController){
        eventsViewController = view
    }
    
    func dettachView(){
        eventsViewController = nil
    }
    
    func setupAuth(){
        self.authUI = FUIAuth.defaultAuthUI()
        self.authUI?.delegate = eventsViewController
        self.authUI?.providers = [FUIFacebookAuth()]
        self.auth = Auth.auth()
        self.auth?.addStateDidChangeListener { (auth, user) in
            guard user != nil else {
                return
            }
            
            self.eventsViewController?.hideSignUpButton()
        }
    }
    
    func loadData() {
        dataManager.getEvents(fromPresenter: self)
    }
    
    //MARK: - Present Data
    public func show(data: [Event]?) {
        eventsViewController?.show(data: data)
    }
    
    // MARK: - Actions
    func openLogin(){
        // TODO: - Hacer un fork en el repositorio de firebase para cambiar NSBundle.mainBundle a Bundle.main
        authUI?.customStringsBundle = Bundle.main
        let authViewController = authUI?.authViewController()
        eventsViewController?.present(authViewController!, animated: true, completion: nil)
    }
    
    public func logOut(){
        do{
        try auth?.signOut()
        }catch{
            print("User not present")
        }
        eventsViewController?.showSignUpButton()
        
        let alert = UIAlertController(title: "¡Adiós!", message: "Esperamos verte pronto", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        eventsViewController?.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    func userExists() -> Bool {
        return auth?.currentUser != nil
    }
}
