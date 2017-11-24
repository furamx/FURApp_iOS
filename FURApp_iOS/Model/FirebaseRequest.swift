//
//  FirebaseRequest.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/21/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseRequest {
    
    //MARK: - Properties
    let dbRef : DatabaseReference!
    
    init(){
        dbRef = Database.database().reference()
    }
    
    func getFacebookToken(completitionHandler:@escaping (_ token: String?) -> ()) {
        dbRef.child("tokens").child("fb-app-token").observe(DataEventType.value, with: { (snapshot) in
            completitionHandler((snapshot.value as! String))
        })
        print("got token")
    }
}
