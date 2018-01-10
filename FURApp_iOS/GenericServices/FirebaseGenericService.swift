//
//  FirebaseRequest.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/21/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol FirebaseProtocol {
    func getFacebookToken(callback:@escaping (String?) -> ())
}

class FirebaseGenericService: FirebaseProtocol {
    
    //MARK: - Properties
    let dbRef : DatabaseReference!
    
    init(){
        dbRef = Database.database().reference()
    }
    
    // Params:
    // - callback: Function to be executed after token is received async
    // To make facebook requests, we need a graph access token.
    // It is not a requirement for the user to be registered, so we use a private token.
    // We chose firebase to prevent malicious users to decompile the app and make bad use of our token.
    func getFacebookToken(callback:@escaping (String?) -> ()) {
//        dbRef.child("tokens").child("fb-app-token").observe(DataEventType.value, with: { (snapshot) in
//            callback((snapshot.value as! String))
//        })
        callback("EAACEdEose0cBANlF9TIgkSAHO2EGuYYcDLM5rpZAHJSwl8fCZBDFLC91qjQsgqEB37TcnnKafDbSU0W9XK7Vvps9u1d0Haa8WRZAkoal4EaBZC0OKe5Xq3YwM94nWtkT0GFdzW8X6bSUcgZA3sMaRzjUl7Uuy02ep95Jb8hXK5MDH3ZCDwdFscpkctgmVmbCIZD")
    }
}
