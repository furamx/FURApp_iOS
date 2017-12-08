//
//  FacebookRequest.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/21/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation
import FacebookCore

class FacebookRequest {
    
    //MARK: - Properties
    let accessToken : String!
    let pageId : String!
    
    //MARK: - Initializers
    init(withAccessToken token: String) {
        accessToken = token
        // FURA
        // pageId = "681255215248937"
        
        // Página con evento activo hoy
        pageId = "111061232291851"
    }
    
    func getPageEvents(completitionHandler: @escaping ([[String:AnyObject]]) -> ()) {
        let params = ["fields" : "id, cover, description, start_time, end_time, is_canceled, is_draft, name, place"]
        let graphRequest = GraphRequest.init(graphPath: "\(pageId!)/events", parameters: params, accessToken: AccessToken.init(authenticationToken: accessToken), httpMethod: .GET, apiVersion: .defaultVersion)
        
        graphRequest.start {
            (urlResponse, requestResult) in
            
            switch requestResult {
                case .failed(let error):
                    print("error in graph request:", error)
                    break
                case .success(let graphResponse):
                    // the graphResponse can't convert the value as string. Everytime it fails.
                    // That would be the best so the data can be parsed via the Codable Protocol
                    if let responseDictionary = graphResponse.dictionaryValue {
                        if let data = responseDictionary["data"] as? [[String:AnyObject]]{
                            completitionHandler(data)
                        }
                    }
                    break
            }
        }
    }
    
    func getEventOfToday(since: String, until: String, completitionHandler: @escaping ([[String:AnyObject]]) -> ()){
        let params = ["fields" : "id, cover, description, start_time, end_time, is_canceled, is_draft, name, place",
                      "since": since,
                      "until": until,
                      "limit": "1"]
        let graphRequest = GraphRequest.init(graphPath: "\(pageId!)/events", parameters: params, accessToken: AccessToken.init(authenticationToken: accessToken), httpMethod: .GET, apiVersion: .defaultVersion)
        graphRequest.start {
            (urlResponse, requestResult) in
            
            switch requestResult {
            case .failed(let error):
                print("error in graph request:", error)
                break
            case .success(let graphResponse):
                // the graphResponse can't convert the value as string. Everytime it fails.
                // That would be the best so the data can be parsed via the Codable Protocol
                if let responseDictionary = graphResponse.dictionaryValue {
                    if let data = responseDictionary["data"] as? [[String:AnyObject]]{
                        completitionHandler(data)
                    }
                }
                break
            }
        }
    }
}
