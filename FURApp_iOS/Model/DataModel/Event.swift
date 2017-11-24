//
//  Event.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/23/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation

struct Event {
    
    let id: String?
    let cover: Cover?
    let description: String?
    let start_time: Date?
    let end_time: Date?
    let is_canceled: Bool?
    let is_draft: Bool?
    let name: String?
    let place: Place?
    
    // To be honest. I don't know if this is the best way of doing things, but I could
    // not make it work with the Codable protocol. Apparently the Graph API can't convert its
    // response to string. For more information go to model/FacebookRequest.swift
    init(withDictionary dict:[String:AnyObject]) {
        let mxLocale = Locale(identifier: "es_MX")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.locale = mxLocale
        
        if let _ = dict["cover"] {
            self.cover = Cover(withDictionary: (dict["cover"] as! [String:AnyObject]))
        }else {
            self.cover = nil
        }
        if let _ = dict["start_time"] {
            self.start_time = dateFormatter.date(from: (dict["start_time"] as! String))
        }else {
            self.start_time = nil
        }
        if let _ = dict["end_time"] {
            self.end_time = dateFormatter.date(from: (dict["end_time"] as! String))
        }else {
            self.end_time = nil
        }
        if let _ = dict["place"] {
            self.place = Place(withDictionary: dict["place"] as! [String:AnyObject])
        }else {
            self.place = nil
        }
        
        self.id = dict["id"] as? String
        self.name = dict["name"] as? String
        self.description = dict["description"] as? String
        self.is_canceled = dict["is_canceled"] as? Bool
        self.is_draft = dict["is_draft"] as? Bool
    }
    
}

struct Cover {
    
    let id: String?
    let offset_x: Int?
    let offset_y: Int?
    let source: String?
    
    init(withDictionary dict: [String:AnyObject]){
        self.id = dict["id"] as? String
        self.offset_x = dict["offset_x"] as? Int
        self.offset_y = dict["offset_y"] as? Int
        self.source = dict["source"] as? String
    }
}

struct Place {
    
    let name: String?
    let location: Location?
    
    init(withDictionary dict: [String:AnyObject]){
        self.name = dict["name"] as? String
        if let loc = dict["location"]{
            self.location = Location(withDictionary: loc as! [String:AnyObject])
        }else{
            self.location = nil
        }
    }
}

struct Location {
    
    let city: String?
    let country: String?
    let latitude: NSNumber?
    let longitud: NSNumber?
    let street: String?
    let zip: String?
    
    init(withDictionary dict: [String:AnyObject]){
        self.city = dict["city"] as? String
        self.country = dict["country"] as? String
        self.latitude = dict["latitude"] as? NSNumber
        self.longitud = dict["longitude"] as? NSNumber
        self.street = dict["street"] as? String
        self.zip = dict["zip"] as? String
    }
}
