//
//  VolunteerService.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 12/28/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation
import FacebookCore

class VolunteerService {
    
    let fbService: FacebookProtocol
    let firService: FirebaseProtocol
    
    init(fbService: FacebookProtocol = FacebookGenericService(), firService: FirebaseProtocol = FirebaseGenericService()) {
        self.fbService = fbService
        self.firService = firService
    }
    
    // Params:
    // - since: a date in strtodate format
    // - until: a date in strtodate format
    // - callback with (Events?): Function to be executed
    // This method makes a Facebook Graph request returning 1 event between the dates `since` and `until`
    func getEventOfToday(since: String, until: String, callback: @escaping (Event?) -> ()){
        // We get the facebook page token from a firebase request
        // For more information about why, go to FirebaseGenericService.swift
        firService.getFacebookToken { (token) in
            guard token != nil else {
                callback(nil)
                return
            }
            
            let params = ["fields" : "id, cover, description, start_time, end_time, is_canceled, is_draft, name, place",
                          "since": since,
                          "until": until,
                          "limit": "1"]
            let graphRequest = GraphRequest.init(graphPath: "\(self.fbService.pageId)/events", parameters: params, accessToken: AccessToken.init(authenticationToken: token!), httpMethod: .GET, apiVersion: .defaultVersion)
            graphRequest.start { (urlResponse, requestResult) in
                switch requestResult {
                    case .failed(let error):
                        print("error in graph request:", error)
                        callback(nil)
                        break
                    case .success(let graphResponse):
                        // FacebookCore BUG
                        // The graphResponse can't convert the value as string. It fails everytime
                        // That would be better so the data can be parsed via the Codable Protocol
                        // For now, we will use dictionaryValue and then parse it as `Event`
                        if let responseDictionary = graphResponse.dictionaryValue {
                            if let data = responseDictionary["data"] as? [[String:AnyObject]] {
                                guard !data.isEmpty, let eventData = data.first else {
                                    callback(nil)
                                    return
                                }
                                
                                let todayEvent = Event(withDictionary: eventData)
                                callback(todayEvent)
                            } else {
                                callback(nil)
                            }
                        } else {
                            callback(nil)
                        }
                        break
                }
            }
        }
    }
}
