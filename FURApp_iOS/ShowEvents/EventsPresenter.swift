//
//  EventsPresenter.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/20/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import Foundation
import Firebase

class EventsPresenter {
    
    // MARK: - Properties
    private var view : EventsViewProtocol?
    private let service: EventsService
    private var events: [Event]?
    private var selectedEvent: Event?
    fileprivate(set) var auth: Auth?
    fileprivate(set) var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    // MARK: - Initializers
    init(withService service: EventsService) {
        self.service = service
    }
    
    func attach(view: EventsViewProtocol){
        self.view = view
    }
    
    func dettachView(){
        view = nil
    }
    
    func load() {
        guard NetworkHelper.isConnectedToNetwork() else {
            view?.displayNoNetwork()
            return
        }
        
        self.setupAuth()
        service.getEvents(callback: show(data:))
    }
    
    // Firebase UI is used to register a new user. This handles the creation of a controller,
    // buttons, and everything else.
    func setupAuth(){
        self.auth = Auth.auth()
        // If a user exists, hide the big signUp button
        self.auth?.addStateDidChangeListener { (auth, user) in
            guard user != nil else {
                return
            }
            
            self.view?.hideSignUpButton()
        }
    }
    
    //MARK: - Present Data
    public func show(data: [Event]?) {
        self.events = data
        var viewData: [EventsViewData]? = []
        let eventsHelper = EventsHelper()
        
        for event in data! {
            if let eventDate = event.start_time {
                var newData = EventsViewData()
                newData.name = event.name
                newData.time = eventsHelper.getTime(fromDate: eventDate)
                newData.date = eventsHelper.getDate(fromDate: eventDate)
                newData.city = "\(event.place?.location?.city ?? "Ciudad"), \(event.place?.location?.country ?? "País")"
                newData.cover_url = event.cover?.source
                viewData?.append(newData)
            }
        }
        view?.display(data: viewData)
    }
    
    // MARK: - Actions
    func openLogin(){
        view?.showSignInView()
    }
    
    public func logOut() {
        do{
            try auth?.signOut()
            view?.showSignUpButton()
            view?.showGoodbyeMessage()
        }catch{
            print("User not present")
        }
    }
    
    func setSelected(eventIndex: Int) {
        self.selectedEvent = events?[eventIndex]
    }
    
    func getSelectedEvent() -> Event? {
        return selectedEvent
    }
    
    // MARK: - Helpers
    func userExists() -> Bool {
        return auth?.currentUser != nil
    }
}
