//
//  DataParser.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/22/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation

class DataParser {
    
    //MARK: - Initializers
    init() { }
    
    func parse(events: [[String:AnyObject]]) -> [Event]? {
        var eventObjects: [Event]? = []
        for event in events {
            let newEvent = Event(withDictionary: event)
            eventObjects?.append(newEvent)
            print(newEvent)
        }
        return eventObjects
    }
    
    func parse(event: [[String:AnyObject]]) -> Event? {
        if (event.isEmpty){
            return nil
        }
        
        if let first = event.first {
            let todayEvent = Event(withDictionary: first)
            return todayEvent
        }else {
            return nil
        }
    }
}
