//
//  FacebookGenericService.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 12/28/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation

protocol FacebookProtocol {
    var pageId: String { get }
}

class FacebookGenericService: FacebookProtocol {
    // FURA
    let pageId = "111061232291851"
    
    // Today's event
    // let pageId = "1317912141619847"
}
