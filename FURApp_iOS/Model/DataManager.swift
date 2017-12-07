//
//  DataManager.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/22/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation

class DataManager {
    
    //MARK: - Initializers
    init() { }
    
    func getEvents(fromPresenter presenter: EventsPresenter) {
        let firebaseRequest = FirebaseRequest()
        firebaseRequest.getFacebookToken { (token) in
            let facebookbRequest = FacebookRequest(withAccessToken: token!)
            facebookbRequest.getPageEvents { (events) in
                let dataParser = DataParser()
                let eventObjects = dataParser.parse(events: events)
                presenter.show(data: eventObjects)
            }
        }
    }
    
    func getEventOfToday(fromPresenter presenter: VolunteerPresenter, today: String, tomorrow: String){
        let firebaseRequest = FirebaseRequest()
        firebaseRequest.getFacebookToken { (token) in
            let facebookRequest = FacebookRequest(withAccessToken: token!)
            facebookRequest.getEventOfToday(since: today, until: tomorrow) { (event) in
                let dataParser = DataParser()
                let eventObject = dataParser.parse(event: event)
                presenter.show(data: eventObject)
            }
        }
    }
}
