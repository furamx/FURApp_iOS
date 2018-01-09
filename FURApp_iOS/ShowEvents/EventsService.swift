//
//  EventsService.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 1/8/18.
//  Copyright © 2018 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation
import FacebookCore

class EventsService {
    
    let fbService: FacebookProtocol
    let firService: FirebaseProtocol
    
    init(fbService: FacebookProtocol = FacebookGenericService(), firService: FirebaseProtocol = FirebaseGenericService()) {
        self.fbService = fbService
        self.firService = firService
    }
    
    // Params:
    // - callback: Function to be executed after request
    // This method gets all the events from a facebook page
    func getEvents(callback:@escaping ([Event]?) -> ()) {
        firService.getFacebookToken { (token) in
            guard token != nil else {
                callback(nil)
                return
            }
            
            let params = ["fields" : "id, cover, description, start_time, end_time, is_canceled, is_draft, name, place"]
            let graphRequest = GraphRequest.init(graphPath: "\(self.fbService.pageId)/events", parameters: params, accessToken: AccessToken.init(authenticationToken: token!), httpMethod: .GET, apiVersion: .defaultVersion)
            
            graphRequest.start {
                (urlResponse, requestResult) in
                
                switch requestResult {
                case .failed(let error):
                    print("error in graph request:", error)
                    break
                case .success(let graphResponse):
                    // FacebookCore BUG
                    // The graphResponse can't convert the value as string. It fails everytime
                    // That would be better so the data can be parsed via the Codable Protocol
                    // For now, we will use dictionaryValue and then parse it as `Event`
                    if let responseDictionary = graphResponse.dictionaryValue {
                        if let data = responseDictionary["data"] as? [[String:AnyObject]] {
                            guard !data.isEmpty else {
                                callback(nil)
                                return
                            }
                            
                            var eventObjects: [Event]! = []
                            for event in data {
                                let newEvent = Event(withDictionary: event)
                                eventObjects.append(newEvent)
                            }
                            callback(eventObjects)
                        }else {
                            callback(nil)
                        }
                    }else {
                        callback(nil)
                    }
                    break
                }
            }
        }
    }
}
